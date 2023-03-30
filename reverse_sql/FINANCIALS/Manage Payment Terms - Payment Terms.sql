/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Terms%20-%20Payment%20Terms.sql $:
 * $Id: Manage Payment Terms - Payment Terms.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT  DISTINCT  PaymentTermHeaderEO.NAME                                        RES_NAME
        , PaymentTermHeaderEO.DESCRIPTION                                 RES_DESCRIPTION
        , PaymentTermHeaderEO.DUE_CUTOFF_DAY                              RES_CUTOFF_DAY
        , PaymentTermHeaderEO.RANK                                        RES_RANK
        , TO_CHAR(PaymentTermHeaderEO.START_DATE_ACTIVE,'DD-Mon-YYYY')    RES_FROM_DATE
        , TO_CHAR(PaymentTermHeaderEO.END_DATE_ACTIVE,'DD-Mon-YYYY')      RES_TO_DATE
		, PaymentTermHeaderEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
		, PaymentTermHeaderEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
		, PaymentTermHeaderEO.CREATED_BY  RSC_CREATED_BY
		, PaymentTermHeaderEO.CREATION_DATE  RSC_CREATION_DATE
		, null RSC_LEDGER_ID
		, null RSC_CHART_OF_ACCOUNTS_ID
		, null RSC_BUSINESS_UNIT_ID
		, null RSC_LEGAL_ENTITY_ID
		, null RSC_ORGANIZATION_ID
		, null RSC_BUSINESS_GROUP_ID
		, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM      AP_TERMS_VL PaymentTermHeaderEO ,AP_TERMS_LINES Detail ,AP_TERMS_ST Term
WHERE   PaymentTermHeaderEO.term_id = Detail.term_id(+)
AND 	PaymentTermHeaderEO.term_id = Term.term_id(+)
ORDER BY  PaymentTermHeaderEO.NAME