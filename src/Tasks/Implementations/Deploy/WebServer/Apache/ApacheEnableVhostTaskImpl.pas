(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheEnableVhostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    DecoratorTaskImpl;

type

    (*!--------------------------------------
     * Task that enable virtual host
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheEnableVhostTask = class(TInterfacedObject, ITask)
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils,
    BaseUnix;

    function TApacheEnableVhostTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var serverName : shortString;
    begin
        if directoryExists('/etc/apache2/sites-enabled') then
        begin
            //debian-based
            if not fileExists('/etc/apache2/sites-enabled/' + serverName + '.conf') then
            begin
                fpSymlink(
                    '/etc/apache2/sites-available/' + serverName + '.conf',
                    '/etc/apache2/sites-enabled/' + serverName + '.conf'
                );
            end;
        end else
        if directoryExists('/etc/httpd/sites-enabled') then
        begin
            //fedora-based
            if not fileExists('/etc/httpd/sites-enabled/' + serverName + '.conf') then
            begin
                fpSymlink(
                    '/etc/httpd/sites-available/' + serverName + '.conf',
                    '/etc/httpd/sites-enabled/' + serverName + '.conf'
                );
            end;
        end else
        begin
            writeln('Cannot create vhost symlink. Unsupported platform or web server');
        end;
        result := self;
    end;
end.