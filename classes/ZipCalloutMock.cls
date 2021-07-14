global class ZipCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"input_index": 0,"city_states": [ {"city": "Gilbert","state_abbreviation": "AZ","state": "Arizona","mailable_city": true}],"zipcodes": [{"zipcode": "85297","zipcode_type": "S","default_city": "Gilbert","county_fips": "04013","county_name": "Maricopa","state_abbreviation": "AZ","state": "Arizona","latitude": 33.27682,"longitude": -111.71932,"precision": "Zip5"}]}]');
        res.setStatusCode(200);
        return res;
    }
}