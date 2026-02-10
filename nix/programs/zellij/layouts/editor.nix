{
  layout = {
    _children = [
      {
        default_tab_template = {
          _children = [
            {
              pane = {
                size = 1;
                borderless = true;
                plugin = {
                  location = "zellij:tab-bar";
                };
              };
            }
            { "children" = { }; }
            {
              pane = {
                size = 2;
                borderless = true;
                plugin = {
                  location = "zellij:status-bar";
                };
              };
            }
          ];
        };
      }
      {
        tab = {
          _props = {
            name = "main";
          };
          _children = [
            {
              pane = {
                split_direction = "vertical";
                _children = [
                  {
                    pane = {
                      size = "20%";
                      name = "explorer";
                      command = "yazi";
                    };
                  }
                  {
                    pane = {
                      _children = [
                        {
                          pane = {
                            name = "editor";
                            focus = true;
                          };
                        }
                        {
                          pane = {
                            size = "30%";
                            name = "terminal";
                          };
                        }
                      ];
                    };
                  }
                ];
              };
            }
          ];
        };
      }
    ];
  };
}
