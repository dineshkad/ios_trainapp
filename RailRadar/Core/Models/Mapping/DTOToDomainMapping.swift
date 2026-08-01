// MARK: - PNR

extension PNRDetails {
    init(dto: PNRStatusDTO) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"   // adjust per provider
        let date = formatter.date(from: dto.journeyDate) ?? Date()

        self.init(
            pnr: dto.pnr,
            trainNumber: dto.trainNumber,
            trainName: dto.trainName,
            boardingStation: dto.boardingStation,
            destinationStation: dto.destinationStation,
            journeyDate: date,
            passengers: dto.passengers.map { PassengerAllocation(dto: $0) }
        )
    }
}

extension PassengerAllocation {
    init(dto: PNRStatusDTO.Passenger) {
        let parsed = PNRStatusParser.parse(dto.currentStatus)
        self.init(
            name: dto.name ?? "Passenger \(dto.serialNumber)",
            coachCode: parsed.coachCode ?? "-",
            berthNumber: parsed.berthNumber ?? 0,
            berthType: parsed.berthType ?? "-",
            travelClass: "SL",   // TODO: derive from provider response when available
            status: parsed.status
        )
    }
}
