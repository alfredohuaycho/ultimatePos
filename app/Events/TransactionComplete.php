<?php

namespace App\Events;

use Illuminate\Queue\SerializesModels;
use App\Transaction;

class TransactionComplete
{
	use SerializesModels;
	/**
	 * 
	 * @var Transaction
	 */
	public $transaction;
	
	public $transactionType;
	
	/**
	 * Create a new event instance.
	 *
	 * @return void
	 */
	public function __construct(Transaction $transaction, $transactionType = null)
	{
		$this->transaction = $transaction;
		$this->transactionType = $transactionType;
	}
}