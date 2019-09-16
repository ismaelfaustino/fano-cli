(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployFcgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy CGI application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployFcgiTaskFactory = class(TInterfacedObject, ITaskFactory)
    public
        function build() : ITask;
    end;

implementation

uses

    NullTaskImpl,
    DeployTaskImpl,
    WebServerTaskImpl,
    ApacheEnableVhostTaskImpl,
    ApacheReloadWebServerTaskImpl,
    ApacheVirtualHostFcgiTaskImpl,
    AdddomainToEtcHostTaskImpl,
    RootCheckTaskImpl;

    function TDeployFcgiTaskFactory.build() : ITask;
    var deployTask : ITask;
    begin
        deployTask := TDeployTaskTask.create(
            TWebServerTask.create(
                TApacheVirtualHostFcgiTask.create(),
                //TNginxVirtualHostCgiTask.create()
                TNullTask.create()
            ),
            TWebServerTask.create(
                TApacheEnableVhostTask.create(),
                //TNginxEnableVirtualHostTask.create()
                TNullTask.create()
            ),
            TAddDomainToEtcHostHostTask.create(),
            TWebServerTask.create(
                TApacheReloadWebServerTask.create(),
                //TNginxReloadWebServerTask.create()
                TNullTask.create()
            )
        );

        //protect to avoid accidentally running without root privilege
        result := TRootCheckTask.create(deployTask);
    end;

end.