<?php
//////////////////////////////////////////////////////////////////////////////////
//                         copyright (c) Arfooo Annuaire                          //
//                    by Hocine Guillaume (c) 2007 - 2008                        //
//                           http://www.arfooo.com/                              //
//    Licence Creative Commons http://creativecommons.org/licenses/by/2.0/fr/   //
//////////////////////////////////////////////////////////////////////////////////
    
class InvoiceController extends AppController
{
    public function orderInvoiceAction($orderId)
    {
        $order = $this->order->findByPk($orderId, 'orderId, invoiceData');
        $invoice = $order->getInvoice();
        
        $role = $this->session->get('role');
        
        if (empty($invoice)
            || !($role == 'administrator'
                 || ($role == 'user' && $invoice['userId'] = $this->userId)
                 || ($role == 'voyant') && $invoice['voyantId'] = $this->userId
        )) {
            $this->return404();   
        }
        
        $this->set('invoice', $invoice);
    }
}
