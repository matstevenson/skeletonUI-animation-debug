import UIKit
import SwiftUI
import SkeletonUI

struct ExampleAlbum: Identifiable {
  var id = UUID()

  var title = "Album name"
  var date = "May 9, 2023"
}

final class AlbumsProvider: ObservableObject {
  @Published var albums: [ExampleAlbum] = []

  func initAlbums() {
    albums = [
        ExampleAlbum(),
        ExampleAlbum(),
        ExampleAlbum(),
        ExampleAlbum()
    ]
  }
}

/// A list of albums with SkeletonUI loaders
struct AlbumList: View {
  @Environment(\.dismiss) var dismiss
  @StateObject var manager: AlbumsProvider = AlbumsProvider()

  var body: some View {
    NavigationView {

      SkeletonList(with: manager.albums, quantity: 3, content: { isLoading, album in
        VStack(alignment: .leading) {
          HStack {
            VStack(alignment: .leading) {
              Text(album?.title)
                .bold()
                .skeleton(with: isLoading)
                .shape(type: .rectangle)

              Text(album?.date)
                .font(.system(size: 10))
                .skeleton(with: isLoading)
                .shape(type: .rectangle)
            }

            Spacer()

            if !isLoading {
              Circle()
                .frame(width: 30, height: 30)
              Circle()
                .frame(width: 30, height: 30)
              Circle()
                .frame(width: 30, height: 30)
            }
          }

          ScrollView(.horizontal) {
            HStack {
              Rectangle()
                .skeleton(with: isLoading)
                .shape(type: .rectangle)
                .frame(width: 80, height: 80)

              Rectangle()
                .skeleton(with: isLoading)
                .shape(type: .rectangle)
                .frame(width: 80, height: 80)

              Rectangle()
                .skeleton(with: isLoading)
                .shape(type: .rectangle)
                .frame(width: 80, height: 80)

            }
          }

        }
        .padding(.vertical, 12)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            manager.initAlbums()
          }
        }

      })

      .toolbar {
        Button("Dismiss") {
          dismiss()
        }
      }
    }

  }
}

#if DEBUG
struct TestSkeletonLoaders_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList()
  }
}
#endif
