@echo off
setlocal enabledelayedexpansion

set /a "prev_id=58"

for /f "tokens=*" %%s in (ids) do (

    set /a "expected_id=!prev_id!+1"
    set /a "id=%%s"

    if !id! NEQ !expected_id! (
        echo Missing id: !expected_id!
    )

    set /a "prev_id=!id!"

)

exit /b