//
//  NotiSettingViewController.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import Combine
import DesignSystem

public class NotiSettingViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: NotiSettingViewModel
    private var cancellables = Set<AnyCancellable>()
    
    public var didTapStartButton: (() -> Void)?
    public var didTapLaterButton: (() -> Void)?
    
    // MARK: - Initialization
    public init(viewModel: NotiSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    private let navigationBar = UINavigationBar()
    private let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: nil, action: nil)
    
    private let titleLabel = UILabel()
    private let characterImageView = UIImageView()
    private let subtitleLabel = UILabel()
    
    private let timeOptionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let startButton = UIButton()
    private let laterButton = UIButton(type: .system)

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        bindViewModel()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Navigation Bar
        setupNavigationBar()
        
        // Title Label
        titleLabel.text = "SYM에게 기록 알람을 받고싶은\n시간을 알려주세요"
        titleLabel.font = FontCase.bold(.title3).toUIFont
        titleLabel.textColor = .coolgray900
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Character Image View
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.image = .imgSimis
        view.addSubview(characterImageView)
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle Label
        subtitleLabel.text = "언제 알람을 보내드릴까요?"
        subtitleLabel.font = FontCase.bold(.subheadline).toUIFont
        subtitleLabel.textColor = .coolgray800
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Collection View
        setupCollectionView()
        
        setupLaterButton()
        
        // Start Button
        setupStartButton()
        
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = backButton
        navigationBar.items = [navItem]
        navigationBar.tintColor = .coolgray800
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.target = self
        backButton.action = #selector(backButtonTapped)
    }
    
    private func setupCollectionView() {
        timeOptionsCollectionView.backgroundColor = .clear
        timeOptionsCollectionView.showsVerticalScrollIndicator = false
        timeOptionsCollectionView.isScrollEnabled = false
        view.addSubview(timeOptionsCollectionView)
        timeOptionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStartButton() {
        startButton.setTitle("SYM 시작하기", for: .normal)
        startButton.backgroundColor = .coolgray300
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
        startButton.layer.cornerRadius = 8
        startButton.isEnabled = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLaterButton() {
        laterButton.setTitle("나중에 설정할래요", for: .normal)
        laterButton.titleLabel?.font = FontCase.semibold(.footnote).toUIFont
        laterButton.setTitleColor(.coolgray400, for: .normal)
        laterButton.addTarget(self, action: #selector(laterButtonTapped), for: .touchUpInside)
        view.addSubview(laterButton)
        laterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            characterImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),
            characterImageView.heightAnchor.constraint(equalToConstant: 120),
            
            subtitleLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 24),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            timeOptionsCollectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            timeOptionsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeOptionsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeOptionsCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            
            laterButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -16),
            laterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    // MARK: - Configure Collection View
    private func configureCollectionView() {
        timeOptionsCollectionView.delegate = self
        timeOptionsCollectionView.dataSource = self
        timeOptionsCollectionView.register(TimeOptionCell.self, forCellWithReuseIdentifier: "TimeOptionCell")
    }
    
    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.$selectedTimeOption
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedOption in
                self?.timeOptionsCollectionView.reloadData()
                self?.updateStartButtonState(isEnabled: selectedOption != nil)
            }
            .store(in: &cancellables)
        
        viewModel.$shouldShowTimePicker
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldShow in
                if shouldShow {
                    self?.showTimePickerSheet()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$customTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] date in
                if self?.viewModel.selectedTimeOption == .custom {
                    self?.timeOptionsCollectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Time Picker Sheet
    private func showTimePickerSheet() {
        let timePickerVC = UIViewController()
        timePickerVC.view.backgroundColor = .white
        
        // TimePicker 추가
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        // 정각만 선택 가능하도록 설정 (분 간격을 60으로 설정)
        timePicker.minuteInterval = 60
        
        // 현재 시간에서 분과 초를 0으로 설정하여 정각으로 맞춤
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: viewModel.customTime)
        if let roundedDate = calendar.date(from: components) {
            timePicker.date = roundedDate
        }
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePickerVC.view.addSubview(timePicker)
        
        // 완료 버튼 추가
        let confirmButton = UIButton()
        confirmButton.setTitle("완료", for: .normal)
        confirmButton.backgroundColor = .coolgray700
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
        confirmButton.layer.cornerRadius = 8
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Store timePicker reference for the confirmButtonAction to use
        objc_setAssociatedObject(confirmButton, UnsafeRawPointer(bitPattern: 1)!, timePicker, .OBJC_ASSOCIATION_RETAIN)
        
        confirmButton.addTarget(self, action: #selector(confirmTimeSelection(_:)), for: .touchUpInside)
        timePickerVC.view.addSubview(confirmButton)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: timePickerVC.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: timePickerVC.view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: timePickerVC.view.trailingAnchor),
            
            confirmButton.leadingAnchor.constraint(equalTo: timePickerVC.view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: timePickerVC.view.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 54),
            confirmButton.bottomAnchor.constraint(equalTo: timePickerVC.view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        // 시트 프레젠테이션 설정
        if let sheet = timePickerVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 12
            sheet.prefersGrabberVisible = true
        }
        
        self.present(timePickerVC, animated: true)
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func startButtonTapped() {
        // Handle start button tap
        didTapStartButton?()
    }
    
    @objc private func confirmTimeSelection(_ sender: UIButton) {
        // Get the associated date picker
        if let timePicker = objc_getAssociatedObject(sender, UnsafeRawPointer(bitPattern: 1)!) as? UIDatePicker {
            viewModel.customTime = timePicker.date
            viewModel.confirmCustomTime()  // 이 메서드 내에서 포맷팅된 시간 문자열을 생성합니다
            dismiss(animated: true)
        }
    }
    
    
    // Add action method:
    @objc private func laterButtonTapped() {
        // Handle later button tap
        didTapLaterButton?()
    }
    
    // MARK: - Helpers
    private func updateStartButtonState(isEnabled: Bool) {
        startButton.isEnabled = isEnabled
        startButton.backgroundColor = isEnabled ? .coolgray800 : .coolgray300
    }
}

// MARK: - Collection View Delegate & DataSource
extension NotiSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TimeOption.allCases.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeOptionCell", for: indexPath) as? TimeOptionCell else {
            return UICollectionViewCell()
        }
        
        let option = TimeOption.allCases[indexPath.item]
        let isSelected = viewModel.selectedTimeOption == option
        
        // 커스텀 시간일 경우 포맷팅된 시간 텍스트 전달
        if option == .custom {
            cell.configure(with: option, isSelected: isSelected, customTimeText: viewModel.customTimeFormatted)
        } else {
            cell.configure(with: option, isSelected: isSelected)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = TimeOption.allCases[indexPath.item]
        viewModel.selectTimeOption(option)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 32) / 3  // 3 columns with spacing
        return CGSize(width: width, height: 100)
    }
}

