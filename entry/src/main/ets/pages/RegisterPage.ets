import { promptAction, router } from '@kit.ArkUI'

// 为TextInput组件扩展样式（与登录页面保持一致）
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

// 为Text组件扩展蓝色文本样式
@Extend(Text) function blueTextStyle() {
  .fontSize(14)
  .fontColor('#1698CE')
  .fontWeight(FontWeight.Medium)
}

@Entry
@Component
struct RegisterPage {
  // 账号输入
  @State account: string = ''
  // 密码输入
  @State password: string = ''
  // 确认密码输入
  @State confirmPassword: string = ''
  // 是否显示加载进度
  @State isShowProgress: boolean = false
  // 定时器ID
  private timeOutId: number = -1
  // 防止重复点击
  @State isRegistering: boolean = false
  // Toast 消息
  @State toastMessage: string = ''
  @State showToast: boolean = false
  // 注册成功标志
  @State registerSuccess: boolean = false

  // 显示Toast方法
  private showToastMessage(message: string): void {
    this.toastMessage = message
    this.showToast = true
    // 2秒后自动隐藏
    setTimeout(() => {
      this.showToast = false
    }, 2000)
  }

  // 注册方法
  register(): void {
    if (this.isRegistering) return;

    if (this.account === '' || this.password === '' || this.confirmPassword === '') {
      // 输入为空时提示
      this.showToastMessage('输入不能为空')
    } else if (this.password !== this.confirmPassword) {
      // 密码不一致提示
      this.showToastMessage('两次输入的密码不一致')
    } else if (this.password.length < 6) {
      // 密码长度验证
      this.showToastMessage('密码长度至少6位')
    } else {
      // 显示加载进度
      this.isShowProgress = true
      this.isRegistering = true

      if (this.timeOutId == -1) {
        // 设置定时器，模拟注册过程
        this.timeOutId = setTimeout(() => {
          this.isShowProgress = false
          this.isRegistering = false
          this.timeOutId = -1

          // 设置注册成功标志
          this.registerSuccess = true

          // 延迟跳转，让用户看到成功提示
          setTimeout(() => {
            // 跳转回登录页面，并传递注册的账号密码
            router.replaceUrl({
              url: 'pages/LoginPage',
              params: {
                account: this.account,
                password: this.password
              }
            })
          }, 1000)
        }, 2000)
      }
    }
  }

  // 页面即将销毁时清除定时器
  aboutToDisappear(): void {
    clearTimeout(this.timeOutId)
    this.timeOutId = -1
    this.isRegistering = false
    this.isShowProgress = false
  }

  build() {
    Column() {
      // 顶部Logo - 宽度约四分之一
      Image($r('app.media.logo'))
        .width('25%')
        .margin({
          top: 80,
          bottom: 16
        })

      // 注册标题
      Text("注册账号")
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor("#182431")

      // 注册提示文本
      Text("注册以登录哟")
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
          .width('100%')
          .textAlign(TextAlign.Start)
        TextInput({
          placeholder: '请输入手机号或用户名',
          text: this.account
        })
          .maxLength(20)
          .enterKeyType(EnterKeyType.Next)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value
          })

        // 密码输入区域
        Text('密码')
          .fontSize(14)
          .fontColor('#5B6670')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({
            top: 12
          })
        TextInput({
          placeholder: '请输入密码',
          text: this.password
        })
          .type(InputType.Password)
          .maxLength(20)
          .enterKeyType(EnterKeyType.Next)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value
          })

        // 确认密码输入区域
        Text('确认密码')
          .fontSize(14)
          .fontColor('#5B6670')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({
            top: 12
          })
        TextInput({
          placeholder: '请再次输入密码',
          text: this.confirmPassword
        })
          .type(InputType.Password)
          .maxLength(20)
          .enterKeyType(EnterKeyType.Done)
          .inputStyle()
          .onChange((value: string) => {
            this.confirmPassword = value
          })
          .onSubmit(() => {
            this.register()
          })

        // 注册按钮
        Button('注册', {
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
            this.register()
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

        // 注册成功提示
        if (this.registerSuccess) {
          Text('注册成功！正在跳转到登录页面...')
            .fontSize(14)
            .fontColor('#07C160')
            .fontWeight(FontWeight.Medium)
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

      // 返回登录入口
      Text('已有账号？返回登录')
        .fontSize(14)
        .fontColor('#3E8AD9')
        .fontWeight(FontWeight.Medium)
        .margin({
          top: 16
        })
        .onClick(() => {
          router.back()
        })

      // 自定义Toast提示
      if (this.showToast) {
        Text(this.toastMessage)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor('#182431')
          .padding(10)
          .borderRadius(8)
          .margin({ top: 20 })
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
    .alignItems(HorizontalAlign.Center)
  }
}