serenity_component(
    Taskbar
    REQUIRED
    TARGETS Taskbar
)

set(SOURCES
    main.cpp
    ClockWidget.cpp
    ShutdownDialog.cpp
    TaskbarButton.cpp
    TaskbarWindow.cpp
    WindowList.cpp
)

serenity_bin(Taskbar)
target_link_libraries(Taskbar LibGUI LibDesktop LibConfig)
serenity_install_headers(Services/Taskbar)
