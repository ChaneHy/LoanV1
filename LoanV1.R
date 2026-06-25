install.packages("shiny")
library(shiny)

###1.R的shiny开发与应用===========

# 定义UI
ui <- fluidPage(                      #创建一个响应式页面布局。
  titlePanel("ChaneYs"),         #设置应用程序的标题
  sidebarLayout(                 #创建一个带有侧边栏和主面板的布局。
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
    ),                 #创建一个滑动条输入控件，用户可以通过它选择直方图的箱数。
    mainPanel(
      plotOutput("distPlot")       #在主面板中显示一个绘图输出
    )
  )
)

# 定义Server逻辑
server <- function(input, output) {        #根据用户输入的箱数生成直方图。
  output$distPlot <- renderPlot({
    x <- faithful$waiting             #使用R内置的faithful数据集中的waiting列作为绘图数据
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

# 运行应用程序
shinyApp(ui = ui, server = server)       #将UI和Server组合成一个完整的Shiny应用程序。





# 定义UI
ui <- fluidPage(
  titlePanel("交互式数据探索"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "选择变量:", choices = names(mtcars))
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# 定义Server逻辑
server <- function(input, output) {
  output$distPlot <- renderPlot({
    variable <- mtcars[[input$variable]]
    hist(variable, main = paste("Histogram of", input$variable), xlab = input$variable)
  })
}


# 运行应用程序
shinyApp(ui = ui, server = server)




###2.R的交互元素===========
#2.1滑块（Slider）
library(shiny)

ui <- fluidPage(
  sliderInput("slider", "选择一个数值范围：", min = 0, max = 100, value = c(25, 75))
)

server <- function(input, output) {
  # 这里可以添加处理逻辑
}

shinyApp(ui, server)

#2.2下拉菜单（Select Input）
ui <- fluidPage(
  selectInput("select", "选择一个选项：", choices = c("选项1", "选项2", "选项3"))
)

server <- function(input, output) {
  # 这里可以添加处理逻辑
}

shinyApp(ui, server)

#2.3 按钮（Button）

ui <- fluidPage(
  actionButton("button", "点击我")
)

server <- function(input, output) {
  observeEvent(input$button, {
    # 这里可以添加点击按钮后的逻辑
  })
}

shinyApp(ui, server)

#2.4文本输入（Text Input）
ui <- fluidPage(
  textInput("text", "输入一些文本：")
)

server <- function(input, output) {
  # 这里可以添加处理逻辑
}

shinyApp(ui, server)

#2.4实际案例：动态图表
library(shiny)
library(ggplot2)

ui <- fluidPage(
  sliderInput("range", "选择范围：", min = 0, max = 100, value = c(25, 75)),
  plotOutput("plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    data <- data.frame(x = 1:100, y = rnorm(100))
    filtered_data <- subset(data, x >= input$range[1] & x <= input$range[2])
    ggplot(filtered_data, aes(x = x, y = y)) + geom_line()
  })
}

shinyApp(ui, server)


###3.R的Shiny反应式编程===========
#3.1反应式表达式
library(shiny)

ui <- fluidPage(
  numericInput("num", "Enter a number", value = 1),
  textOutput("result")
)

server <- function(input, output, session) {
  output$result <- renderText({
    input$num * 2
  })
}

shinyApp(ui, server)

#3.2观察者
library(shiny)

ui <- fluidPage(
  numericInput("num", "Enter a number", value = 1),
  actionButton("save", "Save")
)

server <- function(input, output, session) {
  observeEvent(input$save, {
    saveRDS(input$num, "number.rds")
    print("Number saved!")
  })
}

shinyApp(ui, server)

#3.3实际案例：动态图表
library(shiny)
library(ggplot2)

ui <- fluidPage(
  selectInput("dataset", "Choose a dataset", choices = c("mtcars", "iris", "airquality")),
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    data <- get(input$dataset)
    ggplot(data, aes(x = .data[[names(data)[1]]], y = .data[[names(data)[2]]])) +
      geom_point()
  })
}

shinyApp(ui, server)


###4.什么是Shiny应用部署？=========

#4.1准备你的Shiny应用
# app.R
library(shiny)

ui <- fluidPage(
  titlePanel("简单的Shiny应用"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "选择柱状图的数量:", min = 1, max = 50, value = 30)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}

shinyApp(ui = ui, server = server)

#4.2 选择部署平台
#选择合适的部署平台。以下是几种常见的部署方式：
#ShinyApps.io: RStudio提供的托管服务，适合初学者和小型项目。
#Shiny Server: 可以在你自己的服务器上安装和运行Shiny应用。
#云服务提供商: 如AWS、Google Cloud、Microsoft Azure等，适合大型项目和企业级应用。

#4.3部署到ShinyApps.io
install.packages("rsconnect")
library(rsconnect)
rsconnect::connectApiUser()
rsconnect::setAccountInfo(name='your-account-name', token='your-token', secret='your-secret')

rsconnect::connectApiUser(server = "connect.posit.cloud", mode = "github")


rsconnect::writeManifest()




























