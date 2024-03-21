import { AxiosRequestHeaders } from '@ohos/axios';
import { MatchList, MatchModel } from '../../../models/MatchList';
import { MenuList, MenuModel } from '../../../models/MenuList';
import { ApiList } from '../../../network/http/ApiList';
import axiosClient from '../../../network/http/AxiosRequest';
import { RoutePath } from '../../../route/RoutePath';
import { Router } from '../../../route/Router';
@Component
export default struct MatchView {

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
    List() {
      ListItem() {
        this.BuildCategory()
      }
      this.BuildList()
    }
    .width('100%')
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
        .onClick(() => { this.onItemClick(item.columnNo) })
      })
    }
    .lanes(5)
    .margin({top: 20, bottom: 20})
  }

  onItemClick(index: number) {
    if(index == 157) {
      Router.push(RoutePath.MatchLivePage,)
    }
  }

  @Builder BuildList() {
    List() {
      ForEach(this.matchList, (item: MatchModel) => {
        ListItem() {
          this.BuildItem(item)
        }
      })
    }
    .divider({ strokeWidth: 1, color: 0xF0F0F0, startMargin: 16, endMargin: 16 })
    .backgroundColor(Color.White)
    .borderRadius({topLeft: 20, topRight: 20})
    .padding(16)
  }

  @Builder BuildItem(item: MatchModel) {
    Column({space: 8}) {
      Row({space: 8}) {
        Image(item.cover.cover)
          .width(141)
          .height(88)
        .borderRadius(8)
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
      .width('100%')
      .margin({top: 8})
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      Row() {

        Row() {
          Text(item.browse.toString())
          Divider()
            .width(1)
            .height(10)
          Image($r('app.media.address'))
            .width(12)
            .height(12)
          Text(item.beginTime.split(',')[0])
        }

        Text(this.matchState(item.status))

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  matchState(state: number) {
    if (state == 0) {
      return '未开始';
    } else if (state == 1) {
      return '报名中';
    } else if (state == 2) {
      return '进行中';
    } else if (state == 3) {
      return '已结束';
    }
    return '';
  }
}