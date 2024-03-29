import router from '@ohos.router';
import CopyrightComponent from '../view/CopyrightComponent';
import { CommonConstants } from '../common/constants/CommonConstants';
import axiosClient from '../network/http/AxiosRequest';
import { ApiList } from '../network/http/ApiList';
import { StorageUtil } from '../utils/StorageUtil';
import { StorageKeys } from '../common/constants/StorageKeys';

/**
 * SplashScreenPage is the entry of the application and shows how to develop a front page.
 * Stay in SplashScreenPage for seconds to jump to the MainPage.
 * Developers can replace background images with advertising videos.
 */
@Entry
@Component
struct SplashScreenPage {
  @State pageShowTime: number = CommonConstants.TIME_DEFAULT_VALUE;
  @State intervalID: number = CommonConstants.INTERVAL_ID_DEFAULT;

  aboutToAppear() {
    this.passwordLogin()
  }

  passwordLogin() {
    axiosClient.post<Record<string, string>>({
      url: ApiList.pwdLogin,
      data: {'phone': '13140015925', 'password': 'cw123456'},
      checkResultCode: false,
      checkLoginState: false,
      showLoading: false
    }).then((res) => {
      StorageUtil.put(StorageKeys.Token, res.token)
    });
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Image($r('app.media.bg_splash'))
        .width(CommonConstants.IMAGE_WIDTH)
        .height(CommonConstants.IMAGE_HEIGHT)

      Column() {
        SkipButton({ secondsCount: (CommonConstants.DELAY_SECONDS - this.pageShowTime) })

        Image($r('app.media.slogan'))
          .objectFit(ImageFit.Contain)
          .width(251)
          .height(64)
          .margin({top: 200})

        Blank().height('50%')

        Image($r('app.media.splash_logo'))
          .objectFit(ImageFit.Contain)
          .margin({bottom: 74})

      }.height(CommonConstants.IMAGE_HEIGHT)
    }
    .layoutWeight(CommonConstants.STACK_LAYOUT_WEIGHT)
    .width(CommonConstants.STACK_WIDTH)
  }

  /**
   * When the SplashScreenPage is displayed, switch to the next page after 3 seconds.
   */
  onPageShow() {
    this.intervalID = setInterval(() => {
      this.pageShowTime += CommonConstants.INCREMENT_VALUE;
      if (this.pageShowTime > CommonConstants.DELAY_SECONDS) {
        router.replaceUrl({
          url: CommonConstants.TAB_PAGE_URL
        });
      }
    }, CommonConstants.INTERVAL_DELAY);
  }

  /**
   * When the SplashScreenPage is hide, clear interval.
   */
  onPageHide() {
    clearInterval(this.intervalID);
  }
}

@Component
struct SkipButton {
  @Prop secondsCount: number;

  build() {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.End
    }) {
      Text($r('app.string.skip', this.secondsCount))
        .backgroundColor($r('app.color.rect_area_background'))
        .borderRadius(CommonConstants.SKIP_BUTTON_RADIUS)
        .fontColor(Color.White)
        .width($r('app.float.skip_text_width'))
        .height($r('app.float.skip_text_height'))
        .fontSize($r('app.float.skip_text_size'))
        .margin({
          right: $r('app.float.skip_text_margin_right'),
          top: $r('app.float.skip_text_margin_top')
        })
        .textAlign(TextAlign.Center)
        .border({ width: CommonConstants.SKIP_TEXT_BORDER_WIDTH })
        .borderColor($r('app.color.rect_stroke'))
        .onClick(() => {
          router.replaceUrl({
            url: CommonConstants.MAIN_PAGE_URL
          });
        })
    }
  }
}

@Component
struct AdvertiseIcon {
  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.End
    }) {
      Image($r('app.media.ic_advertise'))
        .objectFit(ImageFit.Contain)
        .width($r('app.float.advertise_button_width'))
        .height($r('app.float.advertise_button_height'))
    }
    .margin($r('app.float.advertise_icon_margin'))
  }
}