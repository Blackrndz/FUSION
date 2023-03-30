/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 SELECT  IbyPaymentMethodsTl.PAYMENT_METHOD_NAME                     RES_NAME
  , IbyPaymentMethodsTl.PAYMENT_METHOD_CODE                        RES_CODE
  , decode(IbyApplicablePmtMthds.APPLICABLE_VALUE_TO,'','All','Specific')     RES_FIRST_PARTY_LEGAL_ENTITIES
  , (SELECT name
  FROM Xle_Entity_Profiles
  WHERE legal_entity_id                         =IbyApplicablePmtMthds.APPLICABLE_VALUE_TO
  AND IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE='PAYER_LE'
  AND IbyApplicablePmtMthds.APPLICATION_ID      =222
  ) AS RES_FIRST_PARTY_LEGAL_ENTITY_L
  ,'' RES_FIRST_PARTY_LEGAL_ENTITY_0
  , IbyApplicablePmtMthds.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , IbyApplicablePmtMthds.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , IbyApplicablePmtMthds.CREATED_BY  RSC_CREATED_BY
  , IbyApplicablePmtMthds.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
  , null RSC_BUSINESS_UNIT_ID
  , IbyApplicablePmtMthds.APPLICABLE_VALUE_TO RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl , IBY_APPLICABLE_PMT_MTHDS IbyApplicablePmtMthds
WHERE IbyPaymentMethodsTl.PAYMENT_METHOD_CODE   = IbyApplicablePmtMthds.PAYMENT_METHOD_CODE
AND (IbyApplicablePmtMthds.PAYMENT_FLOW   = 'DISBURSEMENTS' )
AND (IbyApplicablePmtMthds.APPLICABLE_TYPE_CODE = 'PAYER_LE' )
AND   IbyApplicablePmtMthds.APPLICATION_ID = 222
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')