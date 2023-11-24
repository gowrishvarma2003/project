from geopy.distance import geodesic

class Person:
    def __init__(self, name, address, coordinates):
        self.name = name
        self.address = address
        self.coordinates = coordinates

class Buyer(Person):
    def __init__(self, name, address, coordinates):
        super().__init__(name, address, coordinates)

class Seller(Person):
    def __init__(self, name, address, coordinates, products_available):
        super().__init__(name, address, coordinates)
        self.products_available = products_available

def calculate_distance(coord1, coord2):
    return geodesic(coord1, coord2).kilometers

def route_buyers_to_sellers(buyers, sellers):
    for buyer in buyers:
        nearest_seller = None
        min_distance = float('inf')
        for seller in sellers:
            distance = calculate_distance(buyer.coordinates, seller.coordinates)
            if distance < min_distance and seller.products_available:
                min_distance = distance
                nearest_seller = seller
        if nearest_seller:
            print(f"{buyer.name} is routed to {nearest_seller.name} at {nearest_seller.address}")


# Define latitude and longitude for locations
buyer1_coords = (40.7128, -74.0060)  # Example coordinates for New York City
seller1_coords = (34.0522, -118.2437)  # Example coordinates for Los Angeles

# Create instances of Buyer and Seller with coordinates
buyer1 = Buyer("Buyer 1", "Buyer 1 Address", buyer1_coords)
seller1 = Seller("Seller 1", "Seller 1 Address", seller1_coords, products_available=True)

# Rest of the code remains the same...


buyers_list = [buyer1]  # Add other buyers to this list
sellers_list = [seller1]  # Add other sellers to this list

route_buyers_to_sellers(buyers_list, sellers_list)