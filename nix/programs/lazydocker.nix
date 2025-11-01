{ pkgs, ... }:
{
  programs.lazydocker = {
    enable = true;
    # settings = {
    #   commandTemplates = rec {
    #     dockerCompose = "docker compose";
    #     restartService = "${dockerCompose} restart {{ .Service.Name }}";
    #     up =  "${dockerCompose} up -d";
    #     down = "${dockerCompose} down";
    #     downWithVolumes = "${dockerCompose} down --volumes";
    #     upService =  "${dockerCompose} up -d {{ .Service.Name }}";
    #     startService = "${dockerCompose} start {{ .Service.Name }}";
    #     stopService = "${dockerCompose} stop {{ .Service.Name }}";
    #     serviceLogs = "${dockerCompose} logs --since=60m --follow {{ .Service.Name }}";
    #     viewServiceLogs = "${dockerCompose} logs --follow {{ .Service.Name }}";
    #     rebuildService = "${dockerCompose} up -d --build {{ .Service.Name }}";
    #     recreateService = "${dockerCompose} up -d --force-recreate {{ .Service.Name }}";
    #     allLogs = "${dockerCompose} logs --tail=300 --follow";
    #     viewAlLogs = "${dockerCompose} logs";
    #     dockerComposeConfig = "${dockerCompose} config";
    #     checkDockerComposeConfig = "${dockerCompose} config --quiet";
    #     serviceTop = "${dockerCompose} top {{ .Service.Name }}";
    #   };
    # };
  };
}
