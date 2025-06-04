//
//  LocationPickerViewController.swift
//  LetsBora
//
//  Created by Joel Lacerda on 02/06/25.
//

import UIKit
import MapKit
import CoreLocation

protocol LocationPickerDelegate: AnyObject {
    func didSelectLocation(_ location: EventLocationDetails)
}

class LocationPickerViewController: UIViewController {

    weak var delegate: LocationPickerDelegate?

    // --- UI Elements ---
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Buscar endereços ou locais"
        sc.searchBar.delegate = self
        return sc
    }()

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        map.showsUserLocation = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        map.addGestureRecognizer(tapGesture)
        return map
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
        return tableView
    }()

    private var searchResults: [MKMapItem] = []
    private var selectedMapItem: MKMapItem?
    private var currentAnnotation: MKPointAnnotation?

    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        title = "Selecionar Localização"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false

        setupViews()
        setupLocationManager()
    }

    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(resultsTableView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func doneTapped() {
        guard let item = selectedMapItem else {
            print("Nenhum local selecionado para confirmar.")
            return
        }
        
        let locationDetails = EventLocationDetails(
            name: item.name,
            address: item.placemark.title,
            coordinates: item.placemark.coordinate
        )
        delegate?.didSelectLocation(locationDetails)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let locationInView = gestureRecognizer.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            let placemark = MKPlacemark(coordinate: tappedCoordinate)
            self.selectedMapItem = MKMapItem(placemark: placemark)
            
            updateMapAnnotation(coordinate: tappedCoordinate, title: "Local Selecionado")
            navigationItem.rightBarButtonItem?.isEnabled = true
            
            // Opcional: Fazer reverse geocoding
            reverseGeocodeCoordinate(tappedCoordinate)
        }
    }
    
    private func updateMapAnnotation(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String? = nil) {
        if let existingAnnotation = currentAnnotation {
            mapView.removeAnnotation(existingAnnotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        currentAnnotation = annotation
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }

    private func performSearch(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in

            guard let strongSelf = self else {
                print("Search completion: self (LocationPickerViewController) is nil.")
                return
            }
            
            if let error = error {
                print("Erro na busca MKLocalSearch: \(error.localizedDescription)")
                strongSelf.searchResults = []
                strongSelf.resultsTableView.reloadData()
                strongSelf.resultsTableView.isHidden = strongSelf.searchResults.isEmpty
                return
            }
            
            guard let localResponse = response else {
                print("Resposta da busca MKLocalSearch é nula, sem erro explícito.")
                strongSelf.searchResults = []
                strongSelf.resultsTableView.reloadData()
                strongSelf.resultsTableView.isHidden = strongSelf.searchResults.isEmpty
                return
            }
            
            strongSelf.searchResults = localResponse.mapItems
            strongSelf.resultsTableView.reloadData()
            strongSelf.resultsTableView.isHidden = strongSelf.searchResults.isEmpty
        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Erro no reverse geocoding: \(error.localizedDescription)")
                if let currentTitle = self.currentAnnotation?.title, currentTitle.starts(with: "Lat:") {
                } else {
                    self.currentAnnotation?.title = "Local Selecionado"
                }
                return
            }
            
            if let placemark = placemarks?.first {
                self.selectedMapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                self.currentAnnotation?.title = placemark.name ?? self.selectedMapItem?.placemark.title
                self.currentAnnotation?.subtitle = placemark.thoroughfare
                
                // Se o usuário tocou no mapa, o nome do MKMapItem pode ser nil.
                // Podemos tentar pegar o nome do placemark.
                if self.selectedMapItem?.name == nil {
                    // O título do placemark pode ser um endereço formatado.
                    // Você pode querer algo mais específico se disponível (ex: placemark.name)
                }
            }
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationPickerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização do usuário: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Permissão de localização negada ou restrita.")
        case .notDetermined:
            print("Permissão de localização não determinada.")
        default:
            break
        }
    }
}

//MARK: - UISearchResultsUpdating & UISearchBarDelegate
extension LocationPickerViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            resultsTableView.reloadData()
            resultsTableView.isHidden = true
            return
        }
        
        performSearch(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        resultsTableView.reloadData()
        resultsTableView.isHidden = true
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension LocationPickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let mapItem = searchResults[indexPath.row]
        cell.textLabel?.text = mapItem.name
        cell.detailTextLabel?.text = mapItem.placemark.title // Endereço
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapItem = searchResults[indexPath.row]
        self.selectedMapItem = mapItem
        
        updateMapAnnotation(coordinate: mapItem.placemark.coordinate, title: mapItem.name, subtitle: mapItem.placemark.title)
        
        resultsTableView.isHidden = true
        searchController.isActive = false
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - MKMapViewDelegate
extension LocationPickerViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "LocationPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
