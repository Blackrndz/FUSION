/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Methods%20-%20Payment%20Method%20-%20DFF.sql $:
 * $Id: Manage Payment Methods - Payment Method - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=673##RES##IBY_PAYMENT_METHODS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select IbyPaymentMethodsTl.PAYMENT_METHOD_NAME AS RES_NAME
,IbyPaymentMethodsTl.PAYMENT_METHOD_CODE AS RES_CODE
,Detail.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,Detail.ATTRIBUTE1 
,Detail.ATTRIBUTE2
,Detail.ATTRIBUTE3
,Detail.ATTRIBUTE4
,Detail.ATTRIBUTE5
,Detail.ATTRIBUTE6
,Detail.ATTRIBUTE7
,Detail.ATTRIBUTE8
,Detail.ATTRIBUTE9
,Detail.ATTRIBUTE10
,Detail.ATTRIBUTE11
,Detail.ATTRIBUTE12
,Detail.ATTRIBUTE13
,Detail.ATTRIBUTE14
,Detail.ATTRIBUTE15
,Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl
,IBY_PAYMENT_METHODS_B Detail
WHERE 
(Detail.ATTRIBUTE_CATEGORY IS NOT NULL OR
Detail.ATTRIBUTE1 IS NOT NULL OR 
Detail.ATTRIBUTE2 IS NOT NULL OR 
Detail.ATTRIBUTE3 IS NOT NULL OR 
Detail.ATTRIBUTE4 IS NOT NULL OR 
Detail.ATTRIBUTE5 IS NOT NULL OR 
Detail.ATTRIBUTE6 IS NOT NULL OR 
Detail.ATTRIBUTE7 IS NOT NULL OR 
Detail.ATTRIBUTE8 IS NOT NULL OR 
Detail.ATTRIBUTE9 IS NOT NULL OR 
Detail.ATTRIBUTE10 IS NOT NULL OR 
Detail.ATTRIBUTE11 IS NOT NULL OR 
Detail.ATTRIBUTE12 IS NOT NULL OR 
Detail.ATTRIBUTE13 IS NOT NULL OR 
Detail.ATTRIBUTE14 IS NOT NULL OR 
Detail.ATTRIBUTE15 IS NOT NULL)
AND IbyPaymentMethodsTl.PAYMENT_METHOD_CODE = Detail.PAYMENT_METHOD_CODE(+)
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
order by RES_NAME