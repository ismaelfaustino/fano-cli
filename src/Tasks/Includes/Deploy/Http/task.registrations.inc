(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TDeployHttpTaskFactory.create();
try
    appInst.registerTask(
        'deploy-http',
        '--deploy-http=[server name] Deploy as http web application over http reverse proxy server.' + LineEnding +
        '     --web-server=[web server] if omited, apache is assumed.' + LineEnding +
        '     --doc-root=[document-root] if omited, public directory in current directory is used.' + LineEnding +
        '     --server-ip=[web server ip] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --host=[host where http app listen] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where http app listen] if omited, 20477 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
