import { CommonConstants } from '../../../common/constants/CommonConstants';
import { NewsDataSource } from '../../../datasource/CustomDataSource';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  private data: NewsDataSource = new NewsDataSource()

  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        this.BuildContent()
      }
      .tabBar('资讯')

    }.barMode(BarMode.Scrollable)
  }

  @Builder BuildContent() {
    Column() {
      Grid() {
        LazyForEach(this.data, item => {
          GridItem() {
            Text(item)
          }
        })
      }
      .cachedCount(3)
    }
  }
}