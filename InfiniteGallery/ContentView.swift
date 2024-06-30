import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue]
    
    @State private var currentCard: Int = 0
    
    var body: some View {
        _PagingView(
            config: .init(direction: .horizontal, margin: 8, spacing: 8),
            page: $currentCard,
            views: cards
        )
        .animation(.default, value: currentCard)
    }
    
    private var cards: InfiniteArray<AnyView> {
        InfiniteArray(elements: colors.map { color in
            AnyView(
                Rectangle()
                    .fill(color)
                    .frame(height: 72)
            )
        })
    }
}

final class InfiniteArray<Content>: RandomAccessCollection {
    private var elements: [Content]
    
    init(elements: [Content]) {
        self.elements = elements
    }
    
    var startIndex: Int { Int(Int32.min) }
    var endIndex: Int { Int(Int32.max) }
    
    subscript(position: Int) -> Content {
        let index = (elements.count + (position % elements.count)) % elements.count
        return elements[index]
    }
}

