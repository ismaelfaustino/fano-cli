(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateAdditionalFilesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseProjectTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * additional files (README, .gitignore etc)
     * using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAdditionalFilesTask = class(TBaseProjectTask)
    private
        procedure createAdditionalFiles(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateAdditionalFilesTask.createAdditionalFiles(const dir : string);
    var strReadme : string;
        strGitignore : string;
    begin
        {$INCLUDE src/Tasks/Implementations/Project/Includes/readme.md.inc}
        createTextFile(dir + '/README.md', strReadme);

        {$INCLUDE src/Tasks/Implementations/Project/Includes/gitignore.inc}
        createTextFile(dir + '/.gitignore', strGitignore);
    end;

    function TCreateAdditionalFilesTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    begin
        inherited run(opt, shortOpt, longOpt);
        createAdditionalFiles(baseDirectory);
        result := self;
    end;
end.
