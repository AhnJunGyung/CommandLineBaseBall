//
//  BaseballGame.swift
//  CommandLineBaseBall
//
//  Created by t2023-m0072 on 11/4/24.
//

import Foundation

class BaseballGame {
    
    func start() {
        let answer = makeAnswer()//정답 만드는 함수
        let answerArray = IntToArray(answer)//정답을 배열로 저장
        print(answer)
        outerLoop: while true {
            
            //Lv4 안내문구 출력
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            let getNumber = readLine()
                
            switch Int(getNumber!) {
            case 1: PlayGame(answer, answerArray)
            //case 2: GameRecords()
            //case 3: break outerLoop
            default: break
            }

        }
        
    }
    
    func makeAnswer() -> Int {

        var randomSet: Set<Int> = Set<Int>()
        var answer = 0
        
        /* 랜덤값 생성
         Lv1
         1. Set에 랜덤값 추가
         2. while사용. 조건문 Set 개수 3인지 비교
         2-1. 3보다 작으면 랜덤값 추가
         2-2. 3이면 반복문 탈출
         Lv3
         1. 랜덤값을 0~9로 변경
         */
        while randomSet.count < 3 { randomSet.insert(Int.random(in: 0...9)) }
        
        /* 랜덤값의 Set를 3자리수 Int로 변경
         1. Set -> Array로 변경
         2. 반복문으로 Array에서 추출해낸 값 -> Int 생성
         */
        let randomArray = Array(randomSet)
        
        var stringToInt: String = ""
        for i in 0..<randomArray.count {//배열을 문자열로 변경
            stringToInt += String(randomArray[i])
        }
        
        if let value = Int(stringToInt) { answer = value }//문자열에서 정수 변경
        
        if answer / 100 == 0 { answer *= 10 }//0이 맨 앞인 경우 형변환으로 사라진 0을 맨 뒤에 붙임
        
        return answer
    }
    
    func CheckAnswer(_ answer: Array<Int>, _ input: Array<Int>) -> String {
        var strikeCount: Int = 0
        var ballCount: Int = 0
        var message = ""

        for i in 0..<input.count {
            for j in 0..<input.count {
                if i == j {//스트라이크 판별 : index 동일 한 경우
                    if answer[i] == input[j] { strikeCount += 1
                    }
                } else {//볼 판별 : index 다른 경우
                    if answer[i] == input[j] { ballCount += 1
                    }
                }
            }
        }
        
        //출력 메세지 생성
        if strikeCount >= 1 && ballCount == 0 {//strike만 있을 경우
            message = "\(strikeCount)스트라이크"
        } else if strikeCount == 0 && ballCount >= 1 {//ball만 있을 경우
            message = "\(ballCount)볼"
        } else if strikeCount == 0 && ballCount == 0 {//모두 없을 경우
            message = "Nothing"
        } else {//strike 또는 ball
            message = "\(strikeCount)스트라이크 \(ballCount)볼"
        }
        
        return message
    }

    func IntToArray(_ input: Int) -> Array<Int>{
        var array: Array<Int> = []
        var temp = input
        
        while !(temp == 0) {//Int값을 배열에 입력
            array.append(temp % 10)
            temp /= 10
        }
        
        if array.count == 3 {
            //입력된대로 순서 변경
            temp = array[array.startIndex]
            array[array.startIndex] = array[array.endIndex - 1]
            array[array.endIndex - 1] = temp
        }
        
        return array
    }
    
    func PlayGame(_ answer: Int, _ answerArray: Array<Int>) {
        gameLoop: while true {
            print("숫자를 입력하세요")
            let input = readLine()
                        
            if let inputValue = Int(input!) {// 입력값을 정수로 변환
                var inputArray: Array<Int> = []
                
                inputArray = IntToArray(inputValue) //입력값을 배열로 변환
               
                //입력값이 3자리가 아닌 경우 or 입력값에 0이 포함된 경우
                guard inputArray.count == 3 || inputArray.contains(0) else {
                    print("올바르지 않은 입력값입니다")
                    continue gameLoop//gameLoop 맨 처음부터 다시 반복
                }
                
                //중복된 숫자 있을 경우
                let set: Set<Int> = Set<Int>(inputArray)
                guard set.count == 3 else {
                    print("올바르지 않은 입력값입니다")
                    continue gameLoop//gameLoop 맨 처음부터 다시 반복
                }
                
                if answer == inputValue {// 정답시 반복문 탈출
                    print("정답입니다!")
                    break
                } else {// 정답과 입력값을 비교해 스트라이크/볼 출력
                    print(CheckAnswer(answerArray, inputArray))
                }
                
            } else {//입력값이 숫자가 아닌 경우
                print("올바르지 않은 입력값입니다")
            }
        }
    }
    
    //func GameRecords() {
        
    //}
    
}
