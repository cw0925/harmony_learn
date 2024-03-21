@Component
export default struct MatchUnionView {

  @State unionList: number[] = [1,2,3,4,5,6,7];

  build() {
    List() {
      ListItem() {
        this.BuildUnion()
      }
      this.BuildList()
    }
  }

  @Builder BuildUnion() {
    Row() {
      Column() {
        Text('协会会员卡')
        Text('RANK')
        Text('1')
        Text('拥有数量')
      }
      .width('30%')
      .height(103)
      .backgroundColor(Color.White)
      .border({color: '0xF0F0F0', width: 1})
      .borderRadius(8)

      Column() {
        Text('我的协会')
        Text('ASSOCIATION')
        Row() {
          Column() {
            Text('1')
            Text('我加入的')
          }
        }
      }
      .width('60%')
      .height(103)
      .backgroundColor('0xF6F4FF')
      .border({color: '0xE9E4FB', width: 1})
      .borderRadius(8)
      .margin({left: 16})
      .alignItems(HorizontalAlign.Start)
    }
    .margin({left: 16, top: 20, right: 16, bottom: 20})
  }

  @Builder BuildList() {
    List() {
      ForEach(this.unionList, (item: any) => {
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

  @Builder BuildItem(item: any) {
    Row({space: 8}) {
      Image($r('app.media.address'))
        .width(141)
        .height(88)
        .borderRadius(8)
      Column() {
        Text('item.name')
        Row() {
          Image($r('app.media.address'))
            .width(12)
            .height(12)
          Text('item.place')
        }
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .margin({top: 8})
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
  }
}