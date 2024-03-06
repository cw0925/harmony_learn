import { ApiList } from '../../../network/http/ApiList';
import axiosClient from '../../../network/http/AxiosRequest';
import { NewsDataSource } from '../../../datasource/CustomDataSource';
import { MenuList, MenuModel } from '../../../models/MenuList';
import { MatchList, MatchModel } from '../../../models/MatchList';
import { AxiosRequestHeaders } from '@ohos/axios';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  private data: NewsDataSource = new NewsDataSource()

  @State menuList: MenuModel[] = [];
  @State matchList: MatchModel[] = [];

  aboutToAppear() {
    ///menu
    axiosClient.get<MenuList>({
      'url': ApiList.menuList,
      checkLoginState: false
    }).then((res)=>{
      for (let index = 0; index < res.data.length; index++) {
        const element = res.data[index];
        if(element.status == 1 && element.type == 1) {
          this.menuList.push(element)
        }
      }
    })
    ///赛事列表
    axiosClient.post<MatchList>({
      url: ApiList.matchList,
      data: {
        "data": {
          "categoryIds": [],
          "keyword": "",
          "sort": 1,
          "sorting": 1,
        },
        "page": 1,
        "rows": 10
      },
      headers: {
      'Content-Type': 'application/json',
        'Authorization': 'e43683f9-264d-461e-8e6d-a7e716dfdea9'
    } as AxiosRequestHeaders,
      checkLoginState: false
    }).then((res)=>{
      this.matchList = res.data
    })
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
      ForEach(this.menuList, (item: MenuModel) => {
        ListItem() {
          Column() {
            Image(item.icon)
              .width(53)
              .height(53)
              .margin({bottom: 8})
              .objectFit(ImageFit.Contain)
            Text(item.name)
              .fontSize(12)
              .fontWeight(400)
              .fontColor('#000000')
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
      })
    }
    .lanes(4)
  }

  @Builder BuildList() {
    List() {
      ForEach(this.matchList, (item: MatchModel) => {
        ListItem() {
          this.BuildItem(item)
        }
      })
    }
  }

  @Builder BuildItem(item: MatchModel) {
    Column() {
      Row() {
        Image(item.cover.cover)
          .width(141)
          .height(88)
        Column() {
          Text(item.name)
          Row() {
            Image($r('app.media.address'))
              .width(12)
              .height(12)
            Text(item.place)
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
          Text(item.beginTime)
        }

        Text('扬州市')

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