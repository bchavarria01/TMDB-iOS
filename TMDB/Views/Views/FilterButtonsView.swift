//
//  FilterButtonsView.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//

import UIKit

final class FilterButtonsView: UIView {
    
    // MARK: - Components
    
    lazy var popularButton: ActionableButton = {
        let button = ActionableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.popularOption, for: .normal)
        button.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 5)
        return button
    }()
    
    lazy var topRateButton: ActionableButton = {
        let button = ActionableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.topRatedOption, for: .normal)
        button.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 5)
        return button
    }()
    
    lazy var onTvButton: ActionableButton = {
        let button = ActionableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.onTvOption, for: .normal)
        button.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 5)
        return button
    }()
    
    lazy var airingTodayButton: ActionableButton = {
        let button = ActionableButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.airingOption, for: .normal)
        button.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 5)
        return button
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Attributes
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.Colors.filterButtonsBackColor.color
        setupStackView()
        setupLayout()
        
        cornerRadius(
            with: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ],
            cornerRadii: 8
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    
    func setupStackView() {
        buttonsStackView.addArrangedSubview(popularButton)
        buttonsStackView.addArrangedSubview(topRateButton)
        buttonsStackView.addArrangedSubview(onTvButton)
        buttonsStackView.addArrangedSubview(airingTodayButton)
    }
    
    private func setupLayout() {
        addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
