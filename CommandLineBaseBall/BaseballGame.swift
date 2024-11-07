//
//  BaseballGame.swift
//  CommandLineBaseBall
//
//  Created by t2023-m0072 on 11/4/24.
//

import Foundation

class BaseballGame {
    
    func start() {
        let answer = makeAnswer() //정답 만드는 함수
        
        print(answer)//정답 출력 테스트용 print함수
    }
    
    func makeAnswer() -> Int {

        var randomSet: Set<Int> = Set<Int>() //Set : 중복 불가능한 컬렌션 타입이기 때문에 야구게임에 적합
        var answer = 0
        
        /* 랜덤값 생성
         1. Set에 랜덤값 추가
         2. while사용. 조건문 Set 개수 3인지 비교
         2-1. 3보다 작으면 랜덤값 추가
         2-2. 3이면 반복문 탈출
         */
        while randomSet.count < 3 {
            randomSet.insert(Int.random(in: 1...9))
        }
        
        
        /* 랜덤값의 Set를 3자리수 Int로 변경
         1. Set -> Array로 변경
         2. 반복문으로 Array에서 추출해낸 값 -> Int 생성
         */
        let randomArray = Array(randomSet)
        for i in 0..<randomArray.count {
            
            if randomArray[i] == 0 {
                answer += randomArray[i]
            } else {
                answer += randomArray[i] * Int(pow(Double(10), Double(i)))
            }
        }
        
        return answer
    }
    
}
