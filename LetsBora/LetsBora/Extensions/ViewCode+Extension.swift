//
//  ViewCode+Extension.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/04/25.
//

/// ViewCode Pattern: Organiza a construção de views programaticamente,
/// separando a hierarquia de views, constraints e configurações adicionais.
protocol ViewCode {
    
    /// Adiciona as subviews à hierarquia da view.
    func setHierarchy()
    
    /// Define as constraints Auto Layout das subviews.
    func setConstraints()
    
    /// Configura a view chamando `setHierarchy()` e `setConstraints()`.
    func setupView()
}

extension ViewCode {
    /// Implementação padrão do `setupView` para facilitar reuso.
    func setupView() {
        setHierarchy()
        setConstraints()
    }
}
