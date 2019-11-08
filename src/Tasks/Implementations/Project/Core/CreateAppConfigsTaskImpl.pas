(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * compiler config files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppConfigsTask = class(TCreateFileTask)
    private
        procedure createAppConfigs(const dir : string);
        procedure createCompilerConfigs(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateAppConfigsTask.createCompilerConfigs(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.dev.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.prod.cfg.inc}
    begin
        createTextFile(dir + '/build.cfg', strBuildCfg);
        createTextFile(dir + '/build.cfg.sample', strBuildCfg);

        createTextFile(dir + '/build.dev.cfg', strBuildCfgDev);
        createTextFile(dir + '/build.dev.cfg.sample', strBuildCfgDev);

        createTextFile(dir + '/build.prod.cfg', strBuildCfgProd);
        createTextFile(dir + '/build.prod.cfg.sample', strBuildCfgProd);
    end;

    procedure TCreateAppConfigsTask.createJsonAppConfigs(const dir : string);
    begin
        createTextFile(dir + '/config.json', '{ "appName" : "MyApp" }');
        createTextFile(dir + '/config.json.sample', '{ "appName" : "MyApp" }');
    end;

    procedure TCreateAppConfigsTask.createIniAppConfigs(const dir : string);
    begin
        createTextFile(
            dir + '/config.ini',
            '[fano]' + LineEnding +
            'appName=MyApp'
        );
        createTextFile(
            dir + '/config.ini.sample',
            '[fano]' + LineEnding +
            'appName=MyApp'
        );
    end;

    function TCreateAppConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var configType : string;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createCompilerConfigs(baseDirectory);

        if (opt.hasOption('config')) then
        begin
            configType := opt.getOptionValueDef('config', 'json');
            if (configType = 'ini') then
            begin
                createIniAppConfigs(baseDirectory + '/config');
            end else
            begin
                createJsonAppConfigs(baseDirectory + '/config');
            end;
        end;
        result := self;
    end;
end.
