package org.example.Service;

import org.example.Dto.ApproveDepositDto;
import org.example.Dto.DepositDto;
import org.example.Dto.TransactionDto;
import org.example.Entity.Transaction;

import java.math.BigDecimal;
import java.util.List;

public interface TransactionService {


    public int sendAmount(TransactionDto transactionDto);
//    int depositAmount(DepositDto depositDto);
//    int approvedepositAmount(ApproveDepositDto approveDepositDto);


}
