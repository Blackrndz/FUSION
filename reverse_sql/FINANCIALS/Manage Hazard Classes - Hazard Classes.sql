/* ****************************************************************************
 * $Revision: 60967 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-08 14:29:52 +0700 (Wed, 08 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise.sql 60967 2017-02-08 07:29:52Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PurchasingHazardClassEO.HAZARD_CLASS RES_HAZARD_CLASS
,PurchasingHazardClassEO.DESCRIPTION RES_DESCRIPTION
,PurchasingHazardClassEO.HAZARD_CLASS_CODE RES_CODE
,TO_CHAR(PurchasingHazardClassEO.INACTIVE_DATE,'DD-Mon-YYYY') RES_END_DATE
,PurchasingHazardClassEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PurchasingHazardClassEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PurchasingHazardClassEO.CREATED_BY  RSC_CREATED_BY
,PurchasingHazardClassEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_HAZARD_CLASSES_VL PurchasingHazardClassEO
ORDER BY PurchasingHazardClassEO.HAZARD_CLASS