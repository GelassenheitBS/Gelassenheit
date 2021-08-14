/*
 * Copyright (c) 2021, Linus Groh <linusg@serenityos.org>
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#pragma once

#include <LibJS/Runtime/Object.h>

namespace JS::Temporal {

class PlainMonthDayPrototype final : public Object {
    JS_OBJECT(PlainMonthDayPrototype, Object);

public:
    explicit PlainMonthDayPrototype(GlobalObject&);
    virtual void initialize(GlobalObject&) override;
    virtual ~PlainMonthDayPrototype() override = default;
};

}