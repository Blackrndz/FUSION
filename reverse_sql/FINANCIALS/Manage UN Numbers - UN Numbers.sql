/* ****************************************************************************
 * $Revision: 60967 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-08 14:29:52 +0700 (Wed, 08 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise.sql 60967 2017-02-08 07:29:52Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PurchasingUnNumberEO.UN_NUMBER RES_UN_NUMBER
,PurchasingUnNumberEO.DESCRIPTION RES_DESCRIPTION
,PurchasingUnNumberEO.UN_NUMBER_CODE RES_CODE
,PurchasingHazardClassPEO.HAZARD_CLASS RES_HAZARD_CLASS
,TO_CHAR(PurchasingUnNumberEO.INACTIVE_DATE,'DD-Mon-YYYY') RES_END_DATE
,PurchasingUnNumberEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PurchasingUnNumberEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PurchasingUnNumberEO.CREATED_BY  RSC_CREATED_BY
,PurchasingUnNumberEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_UN_NUMBERS_VL PurchasingUnNumberEO
,PO_HAZARD_CLASSES_VL PurchasingHazardClassPEO
WHERE PurchasingUnNumberEO.HAZARD_CLASS_ID = PurchasingHazardClassPEO.HAZARD_CLASS_ID(+)
ORDER BY PurchasingUnNumberEO.UN_NUMBER