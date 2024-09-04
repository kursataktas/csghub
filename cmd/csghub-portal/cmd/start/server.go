package start

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/spf13/cobra"
	"opencsg.com/portal/config"
	"opencsg.com/portal/internal/routes"
	"opencsg.com/portal/internal/svc"
)

var serverCmd = &cobra.Command{
	Use:   "server",
	Short: "start a server",
	RunE: func(cmd *cobra.Command, args []string) error {
		gin.SetMode(gin.ReleaseMode)
		config, err := config.LoadConfig()
		if err != nil {
			return err
		}

		svcCtx, err := svc.NewServiceContext(config)
		if err != nil {
			return fmt.Errorf("initializing service context: %w", err)
		}

		engine, err := routes.Initialize(svcCtx)
		if err != nil {
			return fmt.Errorf("initializing routes: %w", err)
		}

		engine.Run(":8090")

		return nil
	},
}
