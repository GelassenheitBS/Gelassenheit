/*
 * Copyright (c) 2018-2021, Andreas Kling <kling@serenityos.org>
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include <AK/MappedFile.h>
#include <AK/ScopeGuard.h>
#include <AK/String.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

namespace AK {

ErrorOr<NonnullRefPtr<MappedFile>> MappedFile::map(String const& path)
{
    int fd = open(path.characters(), O_RDONLY | O_CLOEXEC, 0);
    if (fd < 0)
        return Error::from_errno(errno);

    return map_from_fd_and_close(fd, path);
}

ErrorOr<NonnullRefPtr<MappedFile>> MappedFile::map_from_fd_and_close(int fd, [[maybe_unused]] String const& path)
{
    if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0)
        return Error::from_errno(errno);

    ScopeGuard fd_close_guard = [fd] {
        close(fd);
    };

    struct stat st;
    if (fstat(fd, &st) < 0)
        return Error::from_errno(errno);

    auto size = st.st_size;
    auto* ptr = mmap(nullptr, size, PROT_READ, MAP_SHARED, fd, 0);

    if (ptr == MAP_FAILED)
        return Error::from_errno(errno);

#ifdef __gelassenheit__
    if (set_mmap_name(ptr, size, path.characters()) < 0) {
        perror("set_mmap_name");
    }
#endif

    return adopt_ref(*new MappedFile(ptr, size));
}

MappedFile::MappedFile(void* ptr, size_t size)
    : m_data(ptr)
    , m_size(size)
{
}

MappedFile::~MappedFile()
{
    auto rc = munmap(m_data, m_size);
    VERIFY(rc == 0);
}

}
