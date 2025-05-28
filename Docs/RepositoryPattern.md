# Padrão Repository, Injeção de Dependências e MVVM

Este relatório explica os conceitos de Padrão Repository, Injeção de Dependências e o padrão de arquitetura MVVM (Model-View-ViewModel), utilizando exemplos do projeto LetsBora.

## Padrão Repository

O Padrão Repository atua como um intermediário entre a lógica de negócios e a camada de acesso a dados. Ele abstrai a fonte de dados (banco de dados, API, memória, etc.), permitindo que a lógica de negócios interaja com os dados de forma consistente, independentemente de onde eles vêm ou como são armazenados.

**Benefícios:**

*   **Separação de Reponsabilidade:** A lógica de acesso a dados é isolada da lógica de negócios.
*   **Testabilidade:** Facilita a criação de testes unitários, pois é possível mockar o repositório.
*   **Flexibilidade:** Permite trocar a fonte de dados sem afetar a lógica de negócios.

**Exemplo no Projeto LetsBora:**

O protocolo [UserRepository.swift](../LetsBora/LetsBora/Repository/User/UserRepository.swift) define a interface para operações relacionadas a usuários, como criar, recuperar, atualizar e excluir. A implementação [InMemoryUserRepository.swift](../LetsBora/LetsBora/Repository/User/InMemoryUserRepository.swift) fornece uma versão em memória deste repositório.

Note que `InMemoryUserRepository` é declarado como um `actor`. Isso é feito para garantir segurança contra acesso concorrente ao estado mutável (`users`), o que é crucial em ambientes assíncronos onde múltiplas tarefas podem tentar acessar ou modificar a lista de usuários simultaneamente.

```swift:/Users/davipaiva/Documents/iosDev/Bootcamp-iOS/letsBora/LetsBora/LetsBora/Repository/User/UserRepository.swift
enum UserRepositoryError: Error {
    case userNotFound
    case emptyData
}

protocol UserRepository {
    func create(_ user: User) async throws(UserRepositoryError) -> Void
    func retrieve(for id: String) async throws(UserRepositoryError) -> User
    func retrieveAll() async throws(UserRepositoryError) -> [User]
    func update(_ user: User) async throws(UserRepositoryError) -> Void
    func delete(for id: String) async throws(UserRepositoryError) -> Void
}
```

```swift:/Users/davipaiva/Documents/iosDev/Bootcamp-iOS/letsBora/LetsBora/LetsBora/Repository/User/InMemoryUserRepository.swift
import Foundation

actor InMemoryUserRepository: UserRepository {
    
    
    private var users: [User] = MockData.users
    
    func create(_ user: User) async throws(UserRepositoryError) -> Void {
        users.append(user)
    }
    func retrieve(for id: String) async throws(UserRepositoryError) -> User {
        let user = users.first(where: { $0.id == id })
        guard let user else {
            throw .userNotFound
        }
        return user
    }
    
    func retrieveAll() async throws(UserRepositoryError) -> [User] {
        guard !users.isEmpty else {
            throw .emptyData
        }
        return users
    }
    func update(_ user: User) async throws(UserRepositoryError) -> Void {
        let id = user.id

        guard let index = users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        
        users[index] = user
    }
    
    func delete(for id: String) async throws(UserRepositoryError) -> Void {
        guard let index = users.firstIndex(where: {$0.id == id}) else {
            throw .userNotFound
        }
        users.remove(at: index)
    }
}
```

## Injeção de Dependências

Injeção de Dependências (DI) é um padrão de design onde um objeto recebe suas dependências de uma fonte externa, em vez de criá-las internamente. Isso promove o acoplamento fraco e melhora a testabilidade e a manutenibilidade do código.

**Benefícios:**

*   **Acoplamento Fraco:** Componentes são menos dependentes uns dos outros.
*   **Testabilidade:** Facilita a substituição de dependências por mocks ou stubs em testes.
*   **Flexibilidade:** Permite configurar diferentes implementações de uma dependência em diferentes contextos.

**Exemplo no Projeto LetsBora:**

No [RegisterViewModel.swift](../LetsBora/LetsBora/Screens/Register/RegisterViewModel.swift), o `UserRepository` é injetado através do construtor. Isso significa que o `RegisterViewModel` não cria uma instância específica de `UserRepository`, mas a recebe de fora. Por padrão, ele usa `InMemoryUserRepository`, mas poderia facilmente usar outra implementação (como uma que interage com uma API ou banco de dados) sem alterar a lógica interna do ViewModel.

```swift:/Users/davipaiva/Documents/iosDev/Bootcamp-iOS/letsBora/LetsBora/LetsBora/Screens/Register/RegisterViewModel.swift
class RegisterViewModel {
    private let userRepository: UserRepository
    private(set) var users: [User] = []
    
    init(userRepository: UserRepository = InMemoryUserRepository()) {
        self.userRepository = userRepository
    }
    
    func saveUser(user: User) async {
        do {
            try await userRepository.create(user)
            print("User saved successfully: \(user)")
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
    func fetchUsers() async {
        do {
            self.users = try await userRepository.retrieveAll()
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }
    
}
```

## MVVM (Model-View-ViewModel)

MVVM é um padrão de arquitetura que separa a interface do usuário (View) da lógica de negócios (Model) através de um intermediário chamado ViewModel. O ViewModel expõe dados e comandos que a View pode usar, e a View reage às mudanças no ViewModel.

**Componentes:**

*   **Model:** Representa os dados e a lógica de negócios (por exemplo, a struct [User.swift](../LetsBora/LetsBora/Models/User.swift) e a lógica no Repository).
*   **View:** A interface do usuário (no iOS, seria uma `UIViewController` ou `SwiftUI View`). Ela observa o ViewModel e exibe os dados.
*   **ViewModel:** Atua como um mediador entre a View e o Model. Ele contém a lógica de apresentação, formata os dados do Model para a View e lida com as ações do usuário (através de comandos ou funções).

**Benefícios:**

*   **Separação Clara:** Separação nítida entre UI e lógica de negócios.
*   **Testabilidade:** O ViewModel pode ser testado independentemente da View.
*   **Colaboração:** Permite que designers e desenvolvedores trabalhem em paralelo na View e no ViewModel.

**Exemplo no Projeto LetsBora:**

A struct [User.swift](../LetsBora/LetsBora/Models/User.swift) é parte do **Model**. O [RegisterViewModel.swift](../LetsBora/LetsBora/Screens/Register/RegisterViewModel.swift) é o **ViewModel**, que contém a lógica para salvar e buscar usuários usando o `UserRepository` (que interage com o Model). Uma View (não mostrada nos exemplos fornecidos, mas seria a tela de registro) observaria o `RegisterViewModel` para exibir dados (como a lista de usuários) e chamar funções (como `saveUser`).

```swift:/Users/davipaiva/Documents/iosDev/Bootcamp-iOS/letsBora/LetsBora/LetsBora/Models/User.swift
import Foundation
struct User: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var email: String?
    var password: String? // only use in mock examples
    var photo: String? // will be url after
}
```

Em resumo, o projeto LetsBora utiliza o Padrão Repository para gerenciar o acesso a dados de usuários, Injeção de Dependências para fornecer flexibilidade e testabilidade ao `RegisterViewModel`, e segue o padrão MVVM para organizar a lógica de apresentação e separar as preocupações entre a UI e os dados/lógica de negócios.