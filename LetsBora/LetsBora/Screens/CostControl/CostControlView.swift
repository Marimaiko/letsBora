import UIKit

class CostControlView: UIView {
    
    // MARK: - Constants
    private let sectionSpacing: CGFloat = 24
    private let horizontalPadding: CGFloat = 8
    private let labelHorizontalPadding: CGFloat = 32
    private let cellHeight: CGFloat = 60
    
    // MARK: - Constraints para altura dinâmica
    var expensesTableHeightConstraint: NSLayoutConstraint?
    var participantsTableHeightConstraint: NSLayoutConstraint?

    // MARK: - Components
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var costContainer: CostContainer = {
        let container = CostContainer()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var expensesTitleLabel: UILabel = {
        let label = ReusableLabel(text: "Despesas", labelType: .h4)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    lazy var expensesTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ExpenseCell.self, forCellReuseIdentifier: "ExpenseCell")
        table.isScrollEnabled = false
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var participantsTitleLabel: UILabel = {
        let label = ReusableLabel(text: "Participantes", labelType: .h4)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    lazy var participantsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(ParticipantCell.self, forCellReuseIdentifier: "ParticipantCell")
        table.isScrollEnabled = false
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var buttonsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let btNewExpense = UIButton(type: .system)
        btNewExpense.addTarget(nil, action: #selector(CostControlViewController.didTapNewExpense), for: .touchUpInside)
        btNewExpense.translatesAutoresizingMaskIntoConstraints = false
        btNewExpense.setTitle("   + Nova Despesa   ", for: .normal)
        btNewExpense.setTitleColor(.white, for: .normal)
        btNewExpense.backgroundColor = .systemBlue
        btNewExpense.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        btNewExpense.layer.cornerRadius = 8
        container.addSubview(btNewExpense)
        
        let btVouchers = UIButton(type: .system)
        btVouchers.translatesAutoresizingMaskIntoConstraints = false
        btVouchers.setTitle("Comprovantes", for: .normal)
        btVouchers.setTitleColor(.darkGray, for: .normal)
        btVouchers.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        btVouchers.layer.cornerRadius = 8
        container.addSubview(btVouchers)
        
        NSLayoutConstraint.activate([
            btNewExpense.topAnchor.constraint(equalTo: container.topAnchor),
            btNewExpense.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            btVouchers.topAnchor.constraint(equalTo: container.topAnchor),
            btVouchers.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        return container
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension CostControlView: ViewCode {
    
    func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(costContainer)
        contentView.addSubview(expensesTitleLabel)
        contentView.addSubview(expensesTableView)
        contentView.addSubview(participantsTitleLabel)
        contentView.addSubview(participantsTableView)
        contentView.addSubview(buttonsContainer)
    }
    
    func setConstraints() {
        expensesTableHeightConstraint = expensesTableView.heightAnchor.constraint(equalToConstant: 0)
        expensesTableHeightConstraint?.isActive = true
        participantsTableHeightConstraint = participantsTableView.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            costContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            costContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            costContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            costContainer.heightAnchor.constraint(equalToConstant: 146),
            
            expensesTitleLabel.topAnchor.constraint(equalTo: costContainer.bottomAnchor, constant: sectionSpacing),
            expensesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelHorizontalPadding),
            
            expensesTableView.topAnchor.constraint(equalTo: expensesTitleLabel.bottomAnchor, constant: 16),
            expensesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            expensesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            expensesTableHeightConstraint!,
            
            participantsTitleLabel.topAnchor.constraint(equalTo: expensesTableView.bottomAnchor, constant: sectionSpacing),
            participantsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: labelHorizontalPadding),
            
            participantsTableView.topAnchor.constraint(equalTo: participantsTitleLabel.bottomAnchor, constant: 16),
            participantsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            participantsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            participantsTableHeightConstraint!,
            
            buttonsContainer.topAnchor.constraint(equalTo: participantsTableView.bottomAnchor, constant: sectionSpacing),
            buttonsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            buttonsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            buttonsContainer.heightAnchor.constraint(equalToConstant: 40),
            
            buttonsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
}

