//
//  SettingsView.swift
//  LoreOfChampions
//
//  Created by Peter Mihók on 09/06/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

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
            VersionView()
        }
        .tint(.gold3)
    }
}

struct LanguagePickerView: View {
    @EnvironmentObject private var viewModel: ChampionViewModel

    var body: some View {
        Picker("Languages", selection: $viewModel.selectedLocale) {
            ForEach(viewModel.locales, id: \.self) { locale in
                Text(locale.localizedString(forIdentifier: locale.identifier) ?? "")
                    .foregroundStyle(.gold3)
                    .tag(locale.identifier)
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
    @EnvironmentObject private var viewModel: ChampionViewModel

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("version")
                .detailLabelStyle(fontSize: 18, color: .gold3)
            Text("\(viewModel.latestVersion)")
                .detailLabelStyle(fontSize: 24, color: .gold3)
        }
    }
}
