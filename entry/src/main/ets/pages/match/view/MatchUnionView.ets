@Component
export default struct MatchUnionView {

  @State unionList: [] = [];

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
        Text('')
        Text('')
        Text('')
        Text('')
      }
    }
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

        Text('')

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}