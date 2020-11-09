//
//  InspoTableViewController.swift
//  Inspo
//
//  Created by Анастасия Улитина on 07.11.2020.
//

import UIKit
import StoreKit

class InspoTableViewController: UITableViewController, SKPaymentTransactionObserver {

    
    
    let productID = ""
    
    
    var quotesToShow = [
        "Жизнь - это то, что с тобой происходит, пока ты строишь планы. - Джон Леннон",
        "Вы никогда не пересечете океан, если не наберетесь мужества потерять берег из вида. - Христофор Колумб",
        "Есть только один способ избежать критики: ничего не делайте, ничего не говорите и будьте никем. - Аристотель",
        "Как прекрасно, что не нужно ждать ни минуты, чтобы начать делать мир лучше. - Анна Франк",
        "Успех — это способность идти от поражения к поражению, не теряя оптимизма. - Уинстон Черчиль",
        "Если внутренний голос говорит вам, что вы не можете рисовать – рисуйте как можно больше, тогда этот голос затихнет. - Винсент Ван Гог"
    ]
    
    var premiumQuotes = [
        "Лучшее время, чтобы посадить дерево, было 20 лет назад. Следующий подходящий момент - сегодня. Китайская пословица",
        "Что такое деньги? Человек успешен, если утром он просыпается, вечером возвращается в постель, а в перерыве делает то, что ему нравится. Боб Дилан",
        "Быстрее всего учишься в трех случаях — до 7 лет, на тренингах, и когда жизнь загнала тебя в угол. - Стивен Кови",
        "Единственный способ сделать что-то очень хорошо – любить то, что ты делаешь. - Стив Джобс",
        "Перед тем как карабкаться на лестницу успеха, убедитесь, что она прислонена к стене того здания, что вам нужно. - Стивен Кови"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotesToShow.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
        } else {
            cell.textLabel?.text = "Show more quotes"
            cell.textLabel?.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            buyPremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - In-app purchases
    
    func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                SKPaymentQueue.default().finishTransaction(transaction)
                print("S")
            } else if transaction.transactionState == .failed {
                SKPaymentQueue.default().finishTransaction(transaction)
                print("F")
                
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error:\(errorDescription)")
                }
            }
        }
    }

}
