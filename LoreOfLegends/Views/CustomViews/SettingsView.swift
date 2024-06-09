//
//  SettingsView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 09/06/2024.
//

import SwiftUI

struct SettingsView: View {
    let viewModel: ChampionViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    LanguagePickerView()
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsDismissButton()
                }
            }

            VersionView(viewModel: viewModel)
        }
        .tint(.gold3)
    }
}

struct LanguagePickerView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    var body: some View {
        Picker("Languages", selection: $viewModel.currentLocale) {
            ForEach(viewModel.locales, id: \.self) { locale in
                Text(Locale(identifier: locale).localizedString(forIdentifier: locale) ?? "")
                    .foregroundStyle(.gold3)
            }
        }
        .pickerStyle(.navigationLink)
        .tint(.gold3)
    }
}

struct SettingsDismissButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
        .tint(.gold3)
    }
}

struct VersionView: View {
    let viewModel: ChampionViewModel

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("version")
                .detailLabelStyle(fontSize: 18, color: .gold3)
            Text("\(viewModel.latestVersion)")
                .detailLabelStyle(fontSize: 24, color: .gold3)
        }
    }
}
