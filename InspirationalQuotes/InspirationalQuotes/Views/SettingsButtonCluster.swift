import SwiftUI

struct SettingsButtonCluster: View {
    @Binding var isExpanded: Bool
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            // Add button
            if isExpanded {
                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 40, height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .transition(.scale.combined(with: .opacity))
            }

            // Remove button
            if isExpanded {
                Button(action: onRemove) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .frame(width: 40, height: 40)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                .transition(.scale.combined(with: .opacity))
            }

            // Settings gear
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    isExpanded.toggle()
                }
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
            }
        }
    }
}
