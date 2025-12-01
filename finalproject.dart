import 'dart:io';

String input(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? "";
}

int inputInt(String prompt) {
  while (true) {
    try {
      stdout.write(prompt);
      return int.parse(stdin.readLineSync() ?? "");
    } catch (e) {
      print("❌ Invalid number, try again.");
    }
  }
}

class client {
  int id;
  String name;
  String address;
  String phone;
  int bottlesPerWeek;
  int bottlePrice;
  int dueAmount = 0;

  client(
    this.id,
    this.name,
    this.address,
    this.phone,
    this.bottlesPerWeek,
    this.bottlePrice,
  );
}

List<client> clients = [];
client? findClientById(int id) {
  for (var c in clients) {
    if (c.id == id) return c;
  }
  return null;
}

void addClient() {
  print("\n========= Add New Client =========");
  int id = clients.length + 1;

  String name = input("Enter Client Name: ");
  String address = input("Enter Address: ");
  String phone = input("Enter Phone: ");

  int bottles = inputInt("Enter Bottles Per Day: ");
  int price = inputInt("Enter Price Per Bottle: ");

  clients.add(client(id, name, address, phone, bottles, price));

  print("✅ Client Added Successfully!");
  return;
}

void clientReport() {
  print("\n========= Client Report =========");
  for (var c in clients) {
    print("ID: ${c.id}, Name: ${c.name}, Due Amount: ${c.dueAmount}");
  }
  return;
}
void clientSearch(){
  print ("\n========= Search Client =========");
  int id = inputInt ("Enter Client ID to search: ");
  var c = findClientById(id);
  if (c != null) {
    print("ID: ${c.id}, Name: ${c.name}, Address: ${c.address}, Phone: ${c.phone}, Bottles Per Week: ${c.bottlesPerWeek}, Bottle Price: ${c.bottlePrice}, Due Amount: ${c.dueAmount}");
  } else {
    print("Client with ID $id not found.");
  }
  return;
}
void updateClient(){
  print ("\n========= Update Client =========");
  int id = inputInt ("Enter Client ID to update: ");
  var c = findClientById(id);
  if (c != null) {
    String name = input("Enter New Name (current: ${c.name}): ");
    String address = input("Enter New Address (current: ${c.address}): ");
    String phone = input("Enter New Phone (current: ${c.phone}): ");
    int bottles = inputInt("Enter New Bottles Per Week (current: ${c.bottlesPerWeek}): ");
    int price = inputInt("Enter New Price Per Bottle (current: ${c.bottlePrice}): ");

    c.name = name;
    c.address = address;
    c.phone = phone;
    c.bottlesPerWeek = bottles;
    c.bottlePrice = price;

    print(" ✅ Client with ID $id updated successfully.");
  } else {
    print("Client with ID $id not found.");
  }
  return;

}
void  deleteClient(){
  print ("\n========= Delete Client =========");
  int id = inputInt ("Enter Client ID to delete: ");
  var c = findClientById(id);
  if (c != null) {
    clients.remove(c);
    print("Client with ID $id deleted successfully.");
  } else {
    print("Client with ID $id not found.");
  }
  return;
}
void deliveryUpdate(){
print("\n========= Update Delivery =========");
  int id = inputInt ("Enter Client ID for delivery update: ");
  var c = findClientById(id);
  if (c != null) {
    int deliveredBottles = inputInt("Enter number of bottles delivered: ");
    int totalCost = deliveredBottles * c.bottlePrice;
    c.dueAmount += totalCost;
    print("Delivery updated. Total cost Rs $totalCost added to due amount.");
  } else {
    print("Client with ID $id not found.");
  }
  return;
}
void totalBottlesThisMonth() {
  print("\n========= Total Bottles This Month =========");
  int totalBottles = 0;
  for (var c in clients) {
    totalBottles += c.bottlesPerWeek * 4; // Assuming 4 weeks in a month
  }
  print("Total Bottles Delivered This Month: $totalBottles");
  return;
}
void exitProgram() {
  print("Exiting Program. Goodbye!");
  exit(0);

}
void takePayment() {
  print("\n========= Take Payment =========");
  int id = inputInt("Enter Client ID: ");
  var client = findClientById(id);

  if (client == null) {
    print("❌ Client Not Found!");
    return;
  }

  int payment = inputInt("Enter Payment Amount: ");

  if (payment > client.dueAmount) {
    print("❌ Payment exceeds due amount. Transaction aborted.");
    return;
  }

  client.dueAmount -= payment;
  print("💰 Payment Recorded. New Due Amount: Rs ${client.dueAmount}");
}
void main() {

  print ("\n========= Water Delivery Management System =========");
  print ("MENU:");
  print ("1. Add Client");
  print ("2. View Clients");
  print ("3. Search Client");
  print ("4. Update Client");
  print ("5. Delete Client");
  print ("6. Record Delivery");
  print ("7. Total Bottles This Month");
  print ("8. Take Payment");
  print ("9. Exit");

  stdout.write("Enter your choice (1-9): ");
  String? choice = stdin.readLineSync();

  if (choice == '1') {
    addClient();
  } else if (choice == '2') {
    clientReport();
  } else if (choice == '3') {
    clientSearch();
  } else if (choice == '4') {
    updateClient();
  } else if (choice == '5') {
    deleteClient();
  } else if (choice == '6') {
    deliveryUpdate();
  } else if (choice == '7') {
    totalBottlesThisMonth();
  } else if (choice == '8') {
    takePayment();
  } else if (choice == '9') {
    exitProgram();
  } else {
    print("Invalid choice. Please select a valid option.");
  }
  main();
}
