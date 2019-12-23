(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CompositeSessionTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ConditionalCompositeTaskImpl;

type

    (*!--------------------------------------
     * Task that add session-related application config
     * to project creation or fallback to basic config
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCompositeSessionTask = class(TConditionalCompositeTask)
    protected
        function condition(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : boolean; override;
    end;

implementation

    function TCompositeSessionTask.condition(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : boolean;
    begin
        result := opt.hasOption('with-session');
    end;
end.
