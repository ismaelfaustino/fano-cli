strClearUnitsCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    'REM' + LineEnding +
    'REM @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    'REM @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    'REM @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    'REM Scripts to delete all compiled unit files' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'FOR /R bin\unit %i IN (*) DO IF NOT %i == README.md del %i';