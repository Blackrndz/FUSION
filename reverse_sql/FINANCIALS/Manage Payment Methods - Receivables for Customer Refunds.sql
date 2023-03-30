/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT IbyPaymentMethodsTl.PAYMENT_METHOD_NAME RES_NAME
,IbyPaymentMethodsTl.PAYMENT_METHOD_CODE RES_CODE
,(SELECT DISTINCT DECODE(IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE,'PAYER_ORG','Yes','No')
	FROM IBY_APPLICABLE_PMT_MTHDS IbyApplicablePmtMthds
	WHERE IbyApplicablePmtMthds.APPLICATION_ID     = 222
	AND IbyApplicablePmtMthds.PAYMENT_FLOW         = 'DISBURSEMENTS'
	AND IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE = 'PAYER_ORG'
	AND IbyApplicablePmtMthds.PAYMENT_METHOD_CODE  = IbyPaymentMethodsTl.PAYMENT_METHOD_CODE
	) RES_ENABLE_FOR_USE_IN_RECEIVAB
,(SELECT meaning
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_DOMESTIC_OR_FOREIGN'
	AND LookupPEO.LOOKUP_CODE   = SUB_detail.APPLICABLE_VALUE_TO
	) RES_CURRENCY 
,(SELECT meaning
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_DOMESTIC_OR_FOREIGN'
	AND LookupPEO.LOOKUP_CODE   = SUB_detail2.APPLICABLE_VALUE_TO
	) RES_PAYEE_LOCATION 
,SUB_detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,SUB_detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,SUB_detail.CREATED_BY  RSC_CREATED_BY
,SUB_detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl 
,(SELECT IbyApplicablePmtMthds.PAYMENT_METHOD_CODE ,
	IbyApplicablePmtMthds.APPLICABLE_VALUE_TO ,
    LAST_UPDATED_BY ,
    LAST_UPDATE_DATE,
	CREATED_BY,
	CREATION_DATE
	FROM IBY_APPLICABLE_PMT_MTHDS IbyApplicablePmtMthds
	WHERE( ( ( IbyApplicablePmtMthds.PAYMENT_FLOW    = 'DISBURSEMENTS' )
	AND ( IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE = 'FOREIGN_CURRENCY_FLAG' )
	AND ( IbyApplicablePmtMthds.APPLICABLE_VALUE_TO IS NOT NULL )
	AND ( IbyApplicablePmtMthds.APPLICATION_ID       = 222 ) ) )
	) SUB_detail 
,(SELECT IbyApplicablePmtMthds.PAYMENT_METHOD_CODE ,
    IbyApplicablePmtMthds.APPLICABLE_VALUE_TO ,
    LAST_UPDATED_BY ,
    LAST_UPDATE_DATE
	FROM IBY_APPLICABLE_PMT_MTHDS IbyApplicablePmtMthds
	WHERE( ( ( IbyApplicablePmtMthds.PAYMENT_FLOW    = 'DISBURSEMENTS' )
	AND ( IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE = 'CROSS_BORDER_FLAG' )
	AND ( IbyApplicablePmtMthds.APPLICABLE_VALUE_TO IS NOT NULL )
	AND ( IbyApplicablePmtMthds.APPLICATION_ID       = 222 ) ) )
	) SUB_detail2
WHERE IbyPaymentMethodsTl.PAYMENT_METHOD_CODE = SUB_detail.PAYMENT_METHOD_CODE(+)
AND IbyPaymentMethodsTl.PAYMENT_METHOD_CODE   = SUB_detail2.PAYMENT_METHOD_CODE(+)
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
ORDER BY IbyPaymentMethodsTl.PAYMENT_METHOD_NAME