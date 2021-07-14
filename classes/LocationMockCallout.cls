global class LocationMockCallout implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"input_index": 0,"candidate_index": 0,"delivery_line_1": "3301 S Greenfield Rd","last_line": "Gilbert AZ 85297-2176","delivery_point_barcode": "852972176012","components": {"primary_number": "3301","street_predirection": "S","street_name": "Greenfield","street_suffix": "Rd","city_name": "Gilbert","default_city_name": "Gilbert","state_abbreviation": "AZ","zipcode": "85297","plus4_code": "2176","delivery_point": "01","delivery_point_check_digit": "2"},"metadata": {"record_type": "S","zip_type": "Standard","county_fips": "04013","county_name": "Maricopa","carrier_route": "R109","congressional_district": "05","rdi": "Commercial","elot_sequence": "0003","elot_sort": "A","latitude": 33.29103,"longitude": -111.73647,"precision": "Zip9","time_zone": "Mountain","utc_offset": -7},"analysis": {"dpv_match_code": "Y","dpv_footnotes": "AABB","dpv_cmra": "N","dpv_vacant": "N","dpv_no_stat": "N","active": "Y","footnotes": "N#"}}]');
        res.setStatusCode(200);
        return res;
    }
}