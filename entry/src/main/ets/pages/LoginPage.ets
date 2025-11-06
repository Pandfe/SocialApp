import { promptAction, router } from '@kit.ArkUI'

// 为TextInput组件扩展样式
@Extend(TextInput) function inputStyle() {
  .width('100%')
  .height(48)
  .padding({
    left: 12,
    right: 12
  })
  .margin({
    top: 12
  })
  .fontSize(18)
  .borderRadius(12)
  .placeholderColor('#7A8A99')
  .backgroundColor(Color.White)
}

// 为Line组件扩展样式
@Extend(Line) function lineStyle() {
  .width('100%')
  .height(1)
  .backgroundColor('#1A182431')
}

// 为Text组件扩展蓝色文本样式
@Extend(Text) function blueTextStyle() {
  .fontSize(14)
  .fontColor('#1698CE')
  .fontWeight(FontWeight.Medium)
}

@Entry
@Component
struct LoginPage {
  // 账号输入
  @State account: string = ''
  // 密码输入
  @State password: string = ''
  // 是否显示加载进度
  @State isShowProgress: boolean = false
  // 定时器ID
  private timeOutId: number = -1
  // 是否为注册状态
  @State isRegister: boolean = false
  // 预设账号
  @State paccount: string = '13712345678'
  // 预设密码
  @State ppassword: string = '123456'

  // 构建图标按钮
  @Builder imageButton(src: Resource) {
    Button({
      type: ButtonType.Circle,
      stateEffect: true
    }) {
      Image(src)
    }
    .width(30)
    .height(30)
    .backgroundColor("#00ffffff")
  }

  // 登录方法
  login(): void {
    if (this.account === '' || this.password === '') {
      // 输入为空时提示
      promptAction.showToast({
        message: '输入不能为空'
      })
    } else {
      // 验证账号密码
      if ((this.account != this.paccount) || (this.password != this.ppassword)) {
        promptAction.showToast({
          message: '用户名或密码不正确，请重新核对后输入'
        })
      } else {
        // 显示加载进度
        this.isShowProgress = true
        if (this.timeOutId == -1) {
          // 设置定时器，模拟登录过程
          this.timeOutId = setTimeout(() => {
            this.isShowProgress = false
            this.timeOutId = -1

            // 跳转到主页，并传递账号信息
            router.replaceUrl({
              url: 'pages/Index',
              params: {
                account: this.account
              }
            })
          }, 3000)
        }
      }
    }
  }

  // 页面即将销毁时清除定时器
  aboutToDisappear(): void {
    clearTimeout(this.timeOutId)
    this.timeOutId = -1
  }

  // 页面显示时获取路由参数
  onPageShow(): void {
    const params = router.getParams() as Record<string, string>
    if (params) {
      // 如果有账号参数，设置账号
      if (typeof params.account === 'string' && params.account.length > 0) {
        this.account = params.account
        this.paccount = params.account
      }
      // 如果有密码参数，则设置密码
      if (typeof params.password === 'string' && params.password.length > 0) {
        this.password = params.password
        this.ppassword = params.password
      }
    }
  }

  build() {
    Column() {
      // 顶部Logo
      Image($r('app.media.logo'))
        .width(220)
        .height(100)
        .margin({
          top: 60,
          bottom: 8
        })

      // 欢迎文本
      Text("欢迎回来")
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor("#182431")

      Text("登录以获取更多服务")
        .fontSize(14)
        .fontColor("#748499")
        .margin({
          top: 6,
          bottom: 16
        })

      // 表单卡片容器
      Column() {
        // 账号输入区域
        Text('账号')
          .fontSize(14)
          .fontColor('#586670')
        TextInput({
          placeholder: '请输入手机号',
          text: this.account
        })
          .type(InputType.PhoneNumber)
          .maxLength(11)
          .enterKeyType(EnterKeyType.Next)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value
          })

        // 密码输入区域
        Text('密码')
          .fontSize(14)
          .fontColor('#5B6670')
          .margin({
            top: 12
          })

        TextInput({
          placeholder: '请输入密码',
          text: this.password
        })
          .type(InputType.Password)
          .maxLength(6)
          .enterKeyType(EnterKeyType.Done)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value
          })
          .onSubmit(() => {
            this.login()
          })

        // 辅助功能区
        Row() {
          Text('短信验证码登录')
            .blueTextStyle()
            .onClick(() => {
              promptAction.showToast({
                message: '暂未开通短信登录'
              })
            })

          Text('忘记密码')
            .blueTextStyle()
            .onClick(() => {
              promptAction.showToast({
                message: '请联系管理员重置密码'
              })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({
          top: 8
        })

        // 登录按钮
        Button('登录', {
          type: ButtonType.Capsule,
          stateEffect: true
        })
          .width('100%')
          .height(44)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#3E8AD9')
          .opacity(this.isShowProgress ? 0.6 : 1)
          .margin({
            top: 24
          })
          .onClick(() => {
            this.login()
          })

        // 加载进度指示器
        if (this.isShowProgress) {
          LoadingProgress()
            .width(28)
            .height(28)
            .color('#182431')
            .margin({
              top: 16
            })
        }

      }
      .width('100%')
      .borderRadius(20)
      .padding({
        top: 20,
        bottom: 20,
        left: 16,
        right: 16
      })
      .margin({
        top: 24
      })
      .backgroundColor(Color.White)

      // 注册入口
      Text('没有账号？注册一个')
        .fontSize(14)
        .fontColor('#3E8AD9')
        .fontWeight(FontWeight.Medium)
        .margin({
          top: 16
        })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/RegisterPage'
          })
        })

      // 其他方式登录
      Text('其他方式登录')
        .fontSize(12)
        .fontColor('#838D97')
        .fontWeight(FontWeight.Medium)
        .margin({
          top: 28,
          bottom: 12
        })

      // 第三方登录图标
      Row({
        space: 44
      }) {
        this.imageButton($r('app.media.WeiXin'))
        this.imageButton($r('app.media.Phone'))
        this.imageButton($r('app.media.QQ'))
      }

    }
    .width('100%')
    .height('100%')
    .padding({
      left: 12,
      right: 12,
      bottom: 20
    })
    .backgroundColor("#F1F3F5")
  }
}