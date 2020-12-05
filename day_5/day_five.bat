@echo off
setlocal enabledelayedexpansion

set "line="

set /a max_id=0

for /f "tokens=*" %%s in (input) do (

    set /a "row_start=0"
    set /a "row_end=127"
    set /a "column_start=0"
    set /a "column_end=7"

    set "line=%%s"
    set "fbs=!line:~0,7!"
    set "lrs=!line:~7,10!"

    for %%x in (0, 1, 2, 3, 4, 5, 6) do (
        set "char=!fbs:~0,1!"

        if !char!==F (
            set /a "half=!row_end!+!row_start!"
            set /a "row_end=!half!/2"
        )

        if !char!==B (
            set /a "half=!row_end!+!row_start!"
            set /a "row_start=!half!/2"
        )

        set "fbs=!fbs:~1!"
    )

    for %%x in (0, 1, 2) do (
        set "char=!lrs:~0,1!"

        if !char!==L (
            set /a "half=!column_end!+!column_start!"
            set /a "column_end=!half!/2"
        )

        if !char!==R (
            set /a "half=!column_end!+!column_start!"
            set /a "column_start=!half!/2"
        )

        set "lrs=!lrs:~1!"
    )

    set /a seat_id=!row_end!*8+!column_end!

    if "!max_id!" lss "!seat_id!" (
        set /a !max_id!=!seat_id!
    )

    echo !seat_id! !max_id!


)

echo Highest seat id: %max_id%
set /a test=10
set /a res=15

if "%test%" lss "%res%" (
    echo less
)

exit /b