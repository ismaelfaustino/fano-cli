(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateShellScriptsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * shell scripts using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateShellScriptsTask = class(TCreateFileTask)
    private
        fExecBinOutput : string;
        procedure createShellScripts(const dir : string);
        procedure createCleanScripts(const dir : string);
        procedure createConfigSetupScripts(const dir : string);
        procedure createSimulateScripts(const dir : string);
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const contentModifier : IContentModifier;
            const execBinOutDir : string = 'public'
        );

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    {$IFDEF UNIX}
    baseunix, unix,
    {$ENDIF}
    sysutils;

    constructor TCreateShellScriptsTask.create(
        const txtFileCreator : ITextFileCreator;
        const contentModifier : IContentModifier;
        const execBinOutDir : string = 'public'
    );
    begin
        inherited create(txtFileCreator, contentModifier);
        fExecBinOutput := execBinOutDir;
    end;

    procedure TCreateShellScriptsTask.createShellScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.cmd.inc}
    begin
        fContentModifier.setVar('[[EXEC_OUTPUT_DIR]]', fExecBinOutput);
        createTextFile(dir + '/build.sh', fContentModifier.modify(strBuildSh));
        createTextFile(dir + '/build.cmd', fContentModifier.modify(strBuildCmd));
        {$IFDEF UNIX}
        fpChmod(dir + '/build.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createCleanScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/clean.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/clean.cmd.inc}
    begin
        createTextFile(dir + '/clean.sh', strClearUnitsSh);
        createTextFile(dir + '/clean.cmd', strClearUnitsCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/clean.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createConfigSetupScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/config.setup.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/config.setup.cmd.inc}
    begin
        createTextFile(dir + '/config.setup.sh', strConfigSetupSh);
        createTextFile(dir + '/config.setup.cmd', strConfigSetupCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/config.setup.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createSimulateScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/simulate.run.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/simulate.run.cmd.inc}
    begin
        createTextFile(dir + '/simulate.run.sh', strSimulateSh);
        createTextFile(dir + '/simulate.run.cmd', strSimulateCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/simulate.run.sh', &775);
        {$ENDIF}
    end;

    function TCreateShellScriptsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createShellScripts(baseDirectory);
        createCleanScripts(baseDirectory + '/tools');
        createConfigSetupScripts(baseDirectory + '/tools');
        createSimulateScripts(baseDirectory + '/tools');
        result := self;
    end;
end.