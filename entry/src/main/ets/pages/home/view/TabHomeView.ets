import util from '@ohos.util';
import { ApiList } from '../../../common/http/ApiList';
import axiosClient from '../../../common/http/AxiosRequest';
import httpClient from '../../../common/http/request';
import { NewsDataSource } from '../../../datasource/CustomDataSource';
import { HomeModel } from '../../../models/HomeModel';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  private categoryList: any[] = [
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '赛事直播'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '同城约战'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '场馆预定'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '我的赛事'},
  ];

  private matchList: any[] = [
    {'key': 0,'icon': $r('app.media.home_temp'), 'name': '赛事直播'},
    {'key': 1,'icon': $r('app.media.home_temp'), 'name': '同城约战'},
    {'key': 2,'icon': $r('app.media.home_temp'), 'name': '场馆预定'},
    {'key': 3,'icon': $r('app.media.home_temp'), 'name': '我的赛事'},
  ];

  private data: NewsDataSource = new NewsDataSource()

  aboutToAppear() {
    axiosClient.get<Record<string, string>>({
      url: ApiList.menuList,
      params: { "version": '1.2.0' },
      data: { "version": '1.2.0' },
      checkResultCode: false,
      checkLoginState: false,
      showLoading: true
      // headers: { "Accept": "application/json" } as AxiosRequestHeaders
    })

    // httpClient.post<Record<string, string>>({
    //   url: ApiList.baseUrl + ApiList.appGateway + "/common/sendSmsCode",
    //   extraData: { "phone": '13140015925' }
    // })
  }

  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        this.BuildContent()
      }
      .tabBar('赛事')

      TabContent() {
        this.BuildContent()
      }
      .tabBar('协会')

      TabContent() {
        this.BuildContent()
      }
      .tabBar('俱乐部')

    }
    .barMode(BarMode.Scrollable)
    .backgroundColor('#FAFAFA')
  }

  @Builder BuildContent() {
    Column() {
      this.BuildCategory()
      this.BuildList()
    }
    .height('100%')
  }

  @Builder BuildCategory() {
    List() {
      ForEach(this.categoryList, (item: any) => {
        ListItem() {
          Column() {
            Image(item.icon)
              .width(40)
              .height(40)
              .margin(10)
            Text(item.name).fontSize(20)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
      }, item => item.key)
    }
    .lanes(4)
  }

  @Builder BuildList() {
    List() {
      ForEach(this.matchList, (item: any) => {
        ListItem() {
          this.BuildItem()
        }
      }, item => item.key)
    }
  }

  @Builder BuildItem() {
    Column() {
      Row() {
        Image($r('app.media.home_temp'))
          .width(141)
          .height(88)
        Column() {
          Text('2023年全国青少年网球排名总决赛暨中国青少年网球巡回赛总决赛(U12/U14/U16-CTJ-A2000)')
          Row() {
            Image($r('app.media.address'))
              .width(12)
              .height(12)
            Text('扬州市羽毛球协会扬州市羽毛球协会')
          }
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }

      Row() {

        Row() {
          Text('扬州市')
          Divider()
            .width(1)
            .height(10)
          Image($r('app.media.address'))
            .width(12)
            .height(12)
          Text('扬州市羽')
        }

        Row() {
          Image($r('app.media.address'))
            .width(12)
            .height(12)
          Text('扬州市')
        }

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Divider()
    }
  }

  @Builder BuildActivity() {
    Column() {
      Row() {
        Image($r('app.media.home_temp'))
          .width('33%')
        Image($r('app.media.home_temp'))
          .width('33%')
        Image($r('app.media.home_temp'))
          .width('33%')
      }

      Row() {
        Image($r('app.media.home_temp'))
          .width('50%')
        Image($r('app.media.home_temp'))
          .width('50%')
      }
    }
  }

  @Builder BuildGrid() {
    Grid() {
      LazyForEach(this.data, item => {
        GridItem() {
          this.BuildGridItem()
        }
      })
    }
    .cachedCount(3)
    .columnsTemplate('1fr 1fr')
    .rowsGap(8)
    .columnsGap(8)
    .padding({left: 8, right: 8})
  }

  @Builder BuildGridItem() {
    Column() {
      Image($r('app.media.home_temp'))
        .height(224)

      Text('热门场馆热门场馆热门场馆')

      Row() {
        Row() {
          Image($r('app.media.avatar'))
            .width(18)
            .height(18)

          Text('作者')
        }
        Row() {
          Image($r('app.media.heart_grey'))
            .width(18)
            .height(18)

          Text('1')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .borderRadius(10)
    .backgroundColor(Color.White)
  }

  onPageShow() {
    console.log('TabHomeView === onPageShow')
  }
}