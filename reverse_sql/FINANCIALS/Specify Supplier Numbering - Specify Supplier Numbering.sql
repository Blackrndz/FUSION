/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Specify%20Supplier%20Numbering%20-%20Specify%20Supplier%20Numbering.sql $:
 * $Id: Specify Supplier Numbering - Specify Supplier Numbering.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT (PurchasingNextUniqueIdentifi1.current_max_unique_identifier + 1) 	RES_NEXT_SUPPLIER_NUMBER
,PurchasingNextUniqueIdentifi1.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PurchasingNextUniqueIdentifi1.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PurchasingNextUniqueIdentifi1.CREATED_BY  RSC_CREATED_BY
,PurchasingNextUniqueIdentifi1.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.PO_UNIQUE_IDENTIFIER_CONT_ALL 	PurchasingNextUniqueIdentifi1
WHERE PurchasingNextUniqueIdentifi1.table_name = 'POZ_SUPPLIERS'