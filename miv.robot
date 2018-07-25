*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Resource                      /opt/renode/tests/renode-keywords.robot

*** Variables ***
${UART}                       sysbus.uart
${URI}                        @http://antmicro.com/projects/renode

*** Test Cases ***
Should Run Shell
    [Documentation]           Runs Zephyr's 'shell' sample on MiV platform.
    [Tags]                    zephyr  uart  interrupts
    Execute Command           mach create
    Execute Command           machine LoadPlatformDescription @platforms/boards/miv-board.repl

    Execute Command           sysbus LoadELF @${CURDIR}/shell.elf
    Execute Command           showAnalyzer ${UART}

    Create Terminal Tester    ${UART}  shell>

    Start Emulation

    Wait For Prompt On Uart
    Set New Prompt For Uart   sample_module>
    # this sleep here is to prevent against writing too soon on uart - it can happen under high stress of the host CPU - when an uart driver is not initalized which leads to irq-loop
    Sleep                     3
    Write Line To Uart        select sample_module
    Wait For Prompt On Uart
    Write Line To Uart        ping
    Wait For Line On Uart     pong

