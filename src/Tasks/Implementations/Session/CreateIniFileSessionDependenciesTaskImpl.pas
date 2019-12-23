(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateIniFileSessionDependenciesTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateSessionDependenciesTaskImpl;

type

    (*!--------------------------------------
     * Task that add ini file session support to project creation
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateIniFileSessionDependenciesTask = class(TBaseCreateSessionDependenciesTask)
    protected
        procedure createDependencies(const dir : string); override;
    end;

implementation

    procedure TCreateIniFileSessionDependenciesTask.createDependencies(const dir : string);
    begin
    end;

end.
